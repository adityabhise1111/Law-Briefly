# Database Architecture
## Law Briefly — Isar Database Design & Decision Guide

**File:** `lib/core/database/database_architecture.md`  
**Last Updated:** June 2026  
**Status:** Active — production architecture  
**Author:** Law Briefly Architecture Team

---

## Overview

Law Briefly is an offline-first legal education platform for Indian law students. Every feature — bookmarks, personal notes, reading progress, PDF progress, and user profiles — must work completely without an internet connection.

This document explains the database technology chosen, why it was selected over alternatives, how data flows through the application, and how this architecture supports future growth including AI-powered features.

---

## Database Choice: Isar

Law Briefly uses **Isar** as its primary local database.

> Isar is a fast, cross-platform NoSQL database for Flutter,  
> built from the ground up for mobile-first, offline-first applications.

**Package:** `isar: ^3.1.0+1`  
**Code generation:** `isar_generator: ^3.1.0+1`  
**Service layer:** `lib/core/database/isar_database_service.dart`

---

## Why Isar Was Selected

### Considered alternatives

Four database options were evaluated before selecting Isar:

| Option | Type | Verdict |
|---|---|---|
| SharedPreferences | Key-value store | ❌ Rejected |
| Hive | NoSQL (box-based) | ❌ Rejected |
| SQLite (via sqflite) | Relational | ❌ Rejected |
| **Isar** | **NoSQL (typed collections)** | **✅ Selected** |

---

### Why SharedPreferences was rejected

SharedPreferences is a simple key-value store backed by Android's `SharedPreferences` API and iOS's `NSUserDefaults`. It was rejected for the following reasons:

**Not designed for structured data.**
Law Briefly needs to store complex objects — a bookmark has a content ID, title, type, source, and timestamp. Storing this in SharedPreferences requires manual JSON serialization/deserialization for every read and write, with no type safety.

**No querying capability.**
There is no way to query SharedPreferences by field. To find all bookmarks of type `article`, the entire store would need to be loaded and filtered in Dart — unacceptable at scale.

**No indexing.**
Without indexes, lookups are O(n) scans. For a student with 300+ bookmarks and 100+ notes, this becomes a performance problem.

**Size limits.**
SharedPreferences is intended for small amounts of configuration data (theme preference, last session flag). It is not designed to hold hundreds of records.

**Correct use in Law Briefly.**
SharedPreferences is still used for what it is good at: storing the user's `ThemeMode` preference and the session token in `SessionService`. Nothing else.

---

### Why Hive was rejected

Hive is a lightweight, pure-Dart NoSQL database that stores data in boxes (similar to maps). It was a strong candidate but was ultimately rejected.

**No built-in query engine.**
Hive has no native query language. Filtering records (e.g. "get all bookmarks where type is article, sorted by createdAt") requires loading the entire box into memory and filtering in Dart. For large datasets this is both slow and memory-inefficient.

**No native indexes.**
All Hive lookups are either by key (O(1)) or full box scan (O(n)). Isar provides native B-tree indexes on any field, making complex lookups fast without manual effort.

**Lazy box loading is not truly lazy.**
Hive's lazy boxes sound efficient but still load entire records into memory — only deferring the Dart object creation. This is not true lazy loading.

**TypeAdapters are verbose.**
Every Hive model requires a manually written or generated `TypeAdapter`. These add boilerplate and are error-prone when model fields change. Isar's code generation is significantly cleaner and more robust.

**Hive is in maintenance mode.**
As of 2025, Hive development has slowed significantly. Isar (built by the same original author) is the actively maintained successor, purpose-built for Flutter with first-class support.

---

### Why SQLite (sqflite) was rejected

SQLite is a mature, battle-tested relational database. It was carefully considered but rejected for the following reasons.

**Requires schema migrations.**
Every time a table's structure changes — adding a column, renaming a field — a migration must be written and tested. For a fast-moving application like Law Briefly, this overhead slows development significantly. Isar handles schema evolution automatically.

**Raw SQL in Dart is error-prone.**
Using `sqflite` requires writing raw SQL strings in Dart code. These are not checked at compile time. A typo in a column name or query only surfaces at runtime, making bugs harder to catch. Isar uses type-safe Dart query builders checked at compile time.

**No Flutter-native design.**
SQLite was designed for C/C++ and has been adapted for Flutter. The mental model (tables, rows, joins, foreign keys) is borrowed from the server world. Isar is designed specifically for Flutter's widget and reactive model.

**Async overhead.**
`sqflite` requires every database operation to go through a background isolate with manual result parsing. Isar's synchronous read API (for simple lookups) and reactive streams are far better suited to Flutter's build cycle.

**JSON fields are second-class.**
Storing nested structures (like a list of tags on a note, or an array of bookmarked page numbers in a PDF) in SQLite requires either JSON column hacks or additional join tables. Isar stores these natively as typed lists.

---

### Why Isar was selected

Isar satisfies every requirement Law Briefly has — now and in the future.

**Built for Flutter.**
Isar is designed specifically for Flutter applications. Its API uses Dart types directly, integrates with `async`/`await` naturally, and provides reactive streams that work seamlessly with Riverpod and Flutter's `setState`.

**Type-safe queries.**
All queries are written in Dart with full type safety. There are no raw strings that can contain typos. The compiler catches errors before the app runs.

```dart
// Example — type-safe Isar query in Law Briefly
final bookmarks = await isar.bookmarkEntities
    .filter()
    .contentTypeEqualTo('article')
    .sortByCreatedAtDesc()
    .findAll();
```

**Native indexing.**
Any field annotated with `@Index` gets a B-tree index automatically. Lookups by `contentId`, `contentType`, or `createdAt` are O(log n) — fast regardless of how many records exist.

**No migrations needed.**
When a collection's schema changes, Isar handles migration automatically based on the schema version. Fields added with default values are backfilled. Fields removed are dropped. No migration code to write.

**Native list support.**
Isar stores `List<String>` and `List<int>` fields natively — perfect for storing tags on notes, bookmarked page numbers in PDFs, and case law ID arrays.

**Synchronous reads, async writes.**
Simple reads can be done synchronously (no `await`), which is important for UI rendering. Writes use transactions for data integrity.

**Reactive streams.**
Isar's `.watchLazy()` streams emit events whenever a collection changes. Combined with Riverpod providers, the UI automatically rebuilds when bookmarks or notes are added or removed — with no manual state management.

```dart
// Example — reactive Isar stream wired to Riverpod
isar.bookmarkEntities
    .watchLazy(fireImmediately: true)
    .listen((_) => ref.invalidate(bookmarkControllerProvider));
```

**Inspector tool.**
Isar provides a browser-based database inspector (`isar_inspector`) accessible in debug mode. This makes it easy to verify data is being written and read correctly during development — without needing external tools.

**Performance.**
Isar is implemented in Rust and compiled to native code. Benchmarks consistently show Isar outperforming Hive and SQLite on mobile for both reads and writes at scale.

---

## Data Stored in Isar

Law Briefly stores five categories of data in Isar. Each is a separate Isar collection — the equivalent of a table in a relational database.

---

### 1. Bookmarks

**Collection:** `bookmarks_v2`  
**Entity file:** `lib/features/bookmarks/data/models/bookmark_entity.dart`  
**Provider:** `bookmarkControllerProvider`

Bookmarks let students save specific Constitution articles and Act sections for later review.

**Fields stored:**
- `linkedContentId` — ID of the bookmarked article or section (unique, indexed)
- `contentType` — `"article"` or `"section"` (indexed for filtering)
- `createdAt` — timestamp for sorting
- `displayTitle` — cached title to avoid reloading content on list view
- `displaySubtitle` — cached subtitle
- `sourceActId` — which Act the section belongs to (nullable)
- `sourcePartId` — which Part of the Constitution the article belongs to (nullable)

**Why Isar is ideal here:**
The unique index on `linkedContentId` guarantees no duplicate bookmarks for the same content. Filtering by `contentType` uses the index — fast even with hundreds of bookmarks. The cached display fields mean the bookmarks list screen never needs to load full content JSON just to show a title.

---

### 2. Personal Notes

**Collection:** `notes_v2`  
**Entity file:** `lib/features/notes/data/models/note_entity.dart`  
**Provider:** `noteControllerProvider`

Personal notes allow students to write their own annotations, case summaries, and revision notes.

**Fields stored:**
- `noteId` — unique string ID (indexed)
- `title` — note title (indexed for search)
- `content` — full note text (can be long)
- `updatedAt` — last modification timestamp (indexed for sorting)
- `createdAt` — creation timestamp
- `tags` — `List<String>` of tag labels
- `linkedContentId` — optional link to a specific section or article
- `linkedContentType` — type of the linked content

**Why Isar is ideal here:**
Full-text search on `title` using the index allows instant search-as-you-type without scanning all notes. The `List<String>` tags field is stored natively — no join tables. Sorting by `updatedAt` for the "recently edited" view uses the index for O(log n) performance.

---

### 3. Reader Progress

**Collection:** `reader_progress`  
**Entity file:** `lib/core/database/database_models.dart`  
**Status:** Registered, ready for wiring to reader provider

Reader progress tracks where a student left off inside a Constitution article or Act section, enabling seamless resume.

**Fields stored:**
- `contentId` — section or article ID (unique, indexed)
- `lastReadPosition` — index within the content list (for resuming position)
- `scrollOffset` — pixel scroll offset for smooth resume
- `lastOpened` — timestamp (indexed)
- `firstOpened` — when content was first accessed
- `totalReadTimeSeconds` — cumulative reading time
- `isCompleted` — whether the student reached the end

**Why Isar is ideal here:**
The unique index on `contentId` means a single upsert (write-or-replace) call updates progress without checking for existing records first. The `lastOpened` index enables "recently read" lists. The `isCompleted` field supports future progress tracking dashboards.

---

### 4. PDF Progress

**Collection:** `pdf_progress`  
**Entity file:** `lib/core/database/database_models.dart`  
**Status:** Registered, ready for wiring to PDF reader provider

PDF progress tracks the student's position inside Academic Notes PDFs, including bookmarked pages and zoom level.

**Fields stored:**
- `pdfId` — matches `AcademicSubject.id` (unique, indexed)
- `lastPage` — last page the student was on
- `progressPercentage` — 0.0 to 100.0 for progress indicators
- `lastOpened` — timestamp (indexed)
- `firstOpened` — first access timestamp
- `bookmarkedPages` — `List<int>` of page numbers the student bookmarked
- `totalPages` — cached total page count for progress calculation
- `zoomLevel` — zoom level at last session
- `isCompleted` — whether the student has reached the final page

**Why Isar is ideal here:**
The `List<int>` bookmarked pages field is stored natively — no secondary collection needed. The `progressPercentage` field enables subject list screens to show progress bars without loading the full PDF.

---

### 5. User Profile

**Collection:** `user_profiles`  
**Entity file:** `lib/core/database/database_models.dart`  
**Status:** Registered, ready for wiring to profile screen

The user profile stores the student's personal and academic details locally. This is a single-row collection — there is always exactly one profile with `userId == 'current_user'`.

**Fields stored:**
- `userId` — fixed `'current_user'` for single-user mode (unique, indexed)
- `fullName` — student's full name
- `email` — email address
- `mobileNumber` — mobile number
- `college` — college name
- `course` — BA LLB, BBA LLB, LLB, LLM, etc.
- `semester` — current semester
- `city` — city of study
- `state` — state of study
- `createdAt` / `updatedAt` — timestamps
- `avatarPath` — local path to cached avatar image
- `isPremium` — premium subscription flag
- `subscriptionExpiry` — ISO 8601 expiry string
- `deviceId` — device identifier for future sync

**Why Isar is ideal here:**
The unique index on `userId` means the profile can always be fetched with a single O(log n) lookup. The `isPremium` and `subscriptionExpiry` fields are ready for marketplace features without any schema change.

---

## Architecture: Data Flow

```
┌─────────────────────────────────────┐
│              UI Layer               │
│  (Flutter Screens + Widgets)        │
│                                     │
│  ReaderScreen                       │
│  BookmarksScreen                    │
│  NoteEditorScreen                   │
│  AcademicNotesScreen                │
│  SettingsScreen                     │
└──────────────┬──────────────────────┘
               │ watches / reads
               ▼
┌─────────────────────────────────────┐
│           Services Layer            │
│  (Riverpod Providers + Notifiers)   │
│                                     │
│  bookmarkControllerProvider         │
│  noteControllerProvider             │
│  readerControllerProvider           │
│  isBookmarkedProvider               │
└──────────────┬──────────────────────┘
               │ calls
               ▼
┌─────────────────────────────────────┐
│          Repository Layer           │
│  (Data access + domain mapping)     │
│                                     │
│  BookmarkLocalDataSource            │
│  NoteLocalDataSource                │
│  ReaderRepositoryImpl               │
│  PdfProgressRepository              │
└──────────────┬──────────────────────┘
               │ reads / writes
               ▼
┌─────────────────────────────────────┐
│          Database Layer             │
│  (IsarDatabaseService singleton)    │
│                                     │
│  Collection: bookmarks_v2           │
│  Collection: notes_v2               │
│  Collection: reader_progress        │
│  Collection: pdf_progress           │
│  Collection: user_profiles          │
└─────────────────────────────────────┘
```

### Layer responsibilities

**UI Layer**
Screens and widgets. They know nothing about Isar. They watch Riverpod providers and call provider methods. They never import Isar directly.

**Services Layer**
Riverpod providers and StateNotifiers. They orchestrate business logic — when to load, when to invalidate, what to return on error. They call repository methods. They do not know how data is stored.

**Repository Layer**
The only layer that knows data comes from Isar. Data sources (`BookmarkLocalDataSource`, `NoteLocalDataSource`) call `IsarDatabaseService.instance.getDatabase()` and execute Isar queries. They map Isar entities to domain models before returning them upward.

**Database Layer**
`IsarDatabaseService` — a singleton that manages the Isar instance lifecycle. It handles initialization, schema registration, and provides the `Isar` instance to repositories. It is initialized once in `main.dart` before the app starts.

This strict layering means:
- The database can be swapped (e.g. to a remote database) by changing only the repository layer
- The UI never breaks when the database schema changes
- Each layer can be tested independently

---

## Offline-First Benefits

Law Briefly is designed to work completely without internet — both during design and at the architecture level.

### No network dependency for core features

Every feature a student uses daily — reading Acts, reading the Constitution, bookmarking, note-taking, tracking progress — reads from and writes to Isar. None of these features make any network call.

```
Student opens app on train with no signal
        ↓
App loads from local Isar database
        ↓
Student reads BNS Section 103
        ↓
Student bookmarks it
        ↓
Bookmark written to Isar locally
        ↓
Student closes app
        ↓
Next time app opens: bookmark is still there
```

### Data persists across sessions

Unlike in-memory state (which is lost when the app closes), Isar persists data to disk at `getApplicationDocumentsDirectory()`. Every bookmark, note, and progress record survives:
- App close and reopen
- Device restart
- App update (Isar handles schema migration)
- Low memory conditions (OS killing background apps)

### Reactive UI without network

Isar's `.watchLazy()` streams combined with Riverpod mean the UI reacts instantly to data changes — no network round-trip, no polling, no stale data. When a student bookmarks a section, the bookmark icon updates immediately because the Isar write triggers the Riverpod provider which rebuilds the widget.

### Content is bundled, not downloaded

Legal content (Acts, Constitution, Case Laws) is bundled as JSON assets inside the APK. There is no content server to be unavailable. The app works identically on day one with no onboarding network call.

### Graceful degradation

`IsarDatabaseService` is initialized with a try-catch in `main.dart`. If initialization fails (rare edge case on very old Android devices), the app falls back to in-memory storage and still runs — the student can still read content, just without persistence. This is documented in each repository's fallback logic.

---

## Scalability Benefits

### Collection-level isolation

Each data type is a separate Isar collection. Adding new data types (e.g. exam scores, quiz results, downloaded content metadata) requires only a new entity class and schema registration — existing collections are untouched.

### Index-driven performance at scale

Consider a student who uses Law Briefly intensively over 3 years of law school:

| Data | Conservative estimate | Aggressive estimate |
|---|---|---|
| Bookmarks | 500 | 2,000 |
| Personal notes | 200 | 1,000 |
| Reader progress records | 1,000 | 5,000 |
| PDF progress records | 50 | 200 |

Even at the aggressive estimates, Isar's indexed queries return results in microseconds. The B-tree index on `contentId` means lookup time is O(log n) — the difference between 1,000 and 5,000 records is negligible.

### Multi-collection transactions

When a student's account is cleared (logout), all collections must be cleared atomically. Isar's `writeTxn` wraps multiple collection writes in a single transaction — either all clear or none clear. No partial state corruption.

```dart
// Atomic clear across all collections
await isar.writeTxn(() async {
  await isar.bookmarkEntities.clear();
  await isar.noteEntities.clear();
  await isar.readerProgressEntitys.clear();
  await isar.pdfProgressEntitys.clear();
  await isar.userProfileEntitys.clear();
});
```

### Schema evolution without migrations

Law Briefly will add fields to its entities as the product grows. Isar handles this automatically:

- New field added with a default value → existing records are backfilled
- Field renamed → annotate with `@Name('old_name')` to preserve data
- Field removed → Isar drops it from new records, old data is ignored

No migration scripts. No version bumps. No risk of data loss from missed migrations.

### Multi-isolate ready

Flutter apps can run heavy processing in background isolates. Isar is designed for multi-isolate access — the same database instance can be read from the main isolate (UI) and written from a background isolate (e.g. batch content pre-caching) simultaneously without locking.

---

## Future AI Compatibility

Law Briefly's roadmap includes AI-powered features. The Isar architecture is designed to support these from day one.

### 1. AI-powered search across notes and bookmarks

A future AI search feature will let students search their notes and bookmarks using natural language ("find all my notes about fundamental rights") rather than exact keyword matching.

Isar enables this by providing fast structured retrieval to feed into an AI pipeline:

```
Student types: "show me everything about Article 21"
        ↓
AI layer: generate candidate IDs from embeddings
        ↓
Isar query: fetch notes and bookmarks by those IDs
        ↓
AI layer: rank and summarise results
        ↓
UI: display ranked results
```

The Isar layer does not need to change for this — it is already fast and queryable by any field.

### 2. Local vector storage for embeddings

Future AI features may require storing vector embeddings (numerical representations of text for semantic search) alongside content. Isar's `List<double>` support means embeddings can be stored as fields on existing entities or on dedicated embedding entities — no external vector database needed for an offline-first app.

```dart
// Future — embedding stored alongside note
@collection
class NoteEntity {
  // ... existing fields ...

  // AI embedding (1536 dimensions for text-embedding-3-small)
  List<double> contentEmbedding = [];
  DateTime?    embeddingGeneratedAt;
}
```

### 3. AI-generated study summaries

A future feature may automatically generate summaries of bookmarked sections and notes for exam revision. Isar stores the source content IDs and the generated summaries — the AI layer generates once, Isar caches permanently:

```
First request for summary of Section 103
        ↓
Check Isar: summary exists? No.
        ↓
Send section content to on-device AI model
        ↓
AI generates summary
        ↓
Store summary in Isar
        ↓
Return summary to UI (instant on future requests)
```

### 4. Reading pattern analytics for personalised recommendations

Isar's `ReaderProgressEntity` already stores `totalReadTimeSeconds`, `lastOpened`, `firstOpened`, and `isCompleted` for every section and article. This data, aggregated over time, provides a rich signal for AI-powered recommendation:

```
Isar query: which articles has student spent most time on?
        ↓
AI model: recommend related articles based on reading pattern
        ↓
UI: "Based on your reading, you might find Article 32 relevant"
```

No additional database infrastructure is needed — the data is already being collected.

### 5. Offline AI model compatibility

On-device AI models (e.g. Gemma, Phi-3, TensorFlow Lite models) are increasingly viable on mobile. These models run entirely locally, which is compatible with Law Briefly's offline-first constraint. Isar serves as the memory layer for these models — storing their outputs, caching responses, and providing structured input data. The architecture supports this with no changes.

---

## Collection Summary

| Collection | Entity Class | File | Status | Provider |
|---|---|---|---|---|
| `bookmarks_v2` | `BookmarkEntity` | `features/bookmarks/data/models/bookmark_entity.dart` | ✅ Active | `bookmarkControllerProvider` |
| `notes_v2` | `NoteEntity` | `features/notes/data/models/note_entity.dart` | ✅ Active | `noteControllerProvider` |
| `reader_progress` | `ReaderProgressEntity` | `core/database/database_models.dart` | 🔵 Registered | Future wiring |
| `pdf_progress` | `PdfProgressEntity` | `core/database/database_models.dart` | 🔵 Registered | Future wiring |
| `user_profiles` | `UserProfileEntity` | `core/database/database_models.dart` | 🔵 Registered | Future wiring |

**Legend:**
- ✅ Active — fully wired to Riverpod provider and used in production screens
- 🔵 Registered — schema registered in `IsarDatabaseService`, entity defined, not yet wired to provider

---

## Database Initialisation

Isar is initialised once in `main.dart` before the app starts:

```dart
// lib/main.dart
await IsarDatabaseService.instance.initialize(
  dbName:    'law_briefly_v1',
  inspector: kDebugMode,
);
```

All five schemas are registered inside `IsarDatabaseService.initialize()`:

```dart
final List<CollectionSchema<dynamic>> schemas = [
  BookmarkEntitySchema,       // features/bookmarks
  NoteEntitySchema,           // features/notes
  ReaderProgressEntitySchema, // core/database
  PdfProgressEntitySchema,    // core/database
  UserProfileEntitySchema,    // core/database
];

_isar = await Isar.open(
  schemas,
  directory: dir.path,
  name:      dbName ?? _dbName,
  inspector: inspector && kDebugMode,
  compactOnLaunch:
      compact ? const CompactCondition(minFileSize: 512 * 1024) : null,
);
```

`CompactCondition` runs a database compaction (defragmentation) on launch if the file is larger than 512KB. This keeps the database file size manageable over time without manual maintenance.

---

## Running Code Generation

After any change to an entity class annotated with `@collection`, regenerate the `.g.dart` files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

This command regenerates:
- `lib/core/database/database_models.g.dart`
- `lib/features/bookmarks/data/models/bookmark_entity.g.dart`
- `lib/features/notes/data/models/note_entity.g.dart`

Never edit `.g.dart` files manually — they are overwritten on every build.

---

## Decision Summary

| Requirement | SharedPreferences | Hive | SQLite | **Isar** |
|---|---|---|---|---|
| Structured data | ❌ | ✅ | ✅ | ✅ |
| Native indexing | ❌ | ❌ | ✅ | ✅ |
| Type-safe queries | ❌ | ❌ | ❌ | ✅ |
| No migrations needed | ✅ | ✅ | ❌ | ✅ |
| Native list fields | ❌ | ✅ | ❌ | ✅ |
| Reactive streams | ❌ | ⚠️ | ❌ | ✅ |
| Flutter-native design | ❌ | ✅ | ❌ | ✅ |
| Active maintenance | ✅ | ❌ | ✅ | ✅ |
| Debug inspector tool | ❌ | ❌ | ❌ | ✅ |
| Offline-first | ✅ | ✅ | ✅ | ✅ |
| AI/embedding storage | ❌ | ⚠️ | ⚠️ | ✅ |
| Performance at scale | ❌ | ⚠️ | ✅ | ✅ |

Isar is the only option that satisfies every requirement Law Briefly has today and every requirement the roadmap demands tomorrow.

---

*End of document.*
