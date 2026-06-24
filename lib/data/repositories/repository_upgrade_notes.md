# Repository Upgrade Notes
## Law Briefly — LocalLegalRepository → JsonContentLoader Migration Guide

**File:** `lib/data/repositories/repository_upgrade_notes.md`  
**Last Updated:** June 2026  
**Status:** Pre-migration documentation  
**Author:** Law Briefly Architecture Team

---

## Overview

This document explains how `LocalLegalRepository` (currently using mock/hardcoded data) should be migrated to use `JsonContentLoader` for loading real legal content from bundled JSON assets.

This is a planned upgrade — not yet implemented. The current build uses mock data to allow UI and architecture validation before content is loaded. This document serves as the implementation guide for when real content is ready.

---

## Current Flow (Mock Data)

```
Mock Data (hardcoded Dart constants)
        ↓
LocalLegalRepository
        ↓
ReaderController / Provider
        ↓
ReaderScreen / UI
```

### How it works today

Every repository currently returns hardcoded Dart objects. For example:

```dart
// Current — inside reader_repository_impl.dart
Future<ReaderContent> loadActSection({
  required String actId,
  required String sectionId,
}) async {
  // Returns a hardcoded mock object
  return ReaderContent(
    id:      sectionId,
    title:   'Mock Section Title',
    number:  '1',
    content: [
      ContentBlock(type: ContentBlockType.main, text: 'Mock content.'),
    ],
  );
}
```

This approach:
- ✅ Works for building and testing UI
- ✅ No file I/O needed
- ✅ No JSON parsing needed
- ❌ Content cannot be updated without recompiling
- ❌ Does not scale beyond a few test sections
- ❌ Not suitable for production with 400+ articles and 500+ sections

---

## Future Flow (JSON Assets via JsonContentLoader)

```
assets/data/
    acts/
    constitution/
    case_laws/
    academic/
        ↓
JsonContentLoader
(loads + parses + caches JSON from Flutter asset bundle)
        ↓
LocalLegalRepository
(maps parsed JSON to domain models)
        ↓
ReaderController / Provider
        ↓
ReaderScreen / UI
```

### How it will work after migration

`JsonContentLoader` will be a dedicated service responsible for:

- Reading raw JSON from `rootBundle` (Flutter asset system)
- Parsing JSON into intermediate maps
- Maintaining an in-memory cache to avoid repeated asset reads
- Exposing typed loaders per content type

```dart
// Future — JsonContentLoader interface
abstract class JsonContentLoader {
  Future<Map<String, dynamic>> loadAct(String actId);
  Future<Map<String, dynamic>> loadConstitutionPart(String partId);
  Future<Map<String, dynamic>> loadCaseLaw(String caseLawId);
  Future<List<Map<String, dynamic>>> loadAcademicYear(String yearId);
}
```

`LocalLegalRepository` will call `JsonContentLoader` and map results to domain models — it will not know about JSON structure or asset paths.

---

## Acts Loading

### Current (mock)

```dart
// reader_repository_impl.dart
Future<ReaderContent> loadActSection({
  required String actId,
  required String sectionId,
}) async {
  return ReaderContent(
    id:      sectionId,
    title:   'Mock Section',
    number:  '1',
    content: [ContentBlock(type: ContentBlockType.main, text: 'Placeholder.')],
  );
}
```

### JSON Asset Structure (target)

```
assets/data/acts/
    bns_2023.json
    bnss_2023.json
    bsa_2023.json
    ica_1872.json
    ipc_1860.json
    ...
```

Each act JSON file follows this structure:

```json
{
  "act_id": "bns_2023",
  "act_name": "Bharatiya Nyaya Sanhita",
  "year": 2023,
  "chapters": [
    {
      "id": "ch_1",
      "number": 1,
      "roman_numeral": "I",
      "name": "Preliminary",
      "sections": [
        {
          "id": "s_1",
          "number": "1",
          "title": "Short title, extent and commencement",
          "content": [
            {
              "type": "main",
              "text": "This Act may be called the Bharatiya Nyaya Sanhita, 2023."
            }
          ],
          "case_law_ids": ["maneka_gandhi_v_uoi", "ak_gopalan_v_state"]
        }
      ]
    }
  ]
}
```

### Future implementation

```dart
// Future — reader_repository_impl.dart
Future<ReaderContent> loadActSection({
  required String actId,
  required String sectionId,
}) async {
  // 1. Load act JSON via JsonContentLoader (cached after first load)
  final actJson = await _jsonLoader.loadAct(actId);

  // 2. Find the section across all chapters
  final section = _findSection(actJson, sectionId);
  if (section == null) throw ContentNotFoundException(sectionId);

  // 3. Map to domain model
  return ReaderContent.fromActSectionJson(section, actId: actId);
}
```

### Migration checklist for Acts

- [ ] Create `assets/data/acts/<actId>.json` for each Act
- [ ] Add all act asset paths to `pubspec.yaml` under `assets/data/acts/`
- [ ] Implement `JsonContentLoader.loadAct(String actId)`
- [ ] Implement `ReaderContent.fromActSectionJson()`
- [ ] Update `reader_repository_impl.dart` to call `JsonContentLoader`
- [ ] Remove mock fallback once all acts have JSON files
- [ ] Add error handling for missing act files (`AssetLoadException`)

---

## Constitution Loading

### Current (mock)

The `MockConstitutionData` class inside `constitution_screen.dart` holds all 22+ parts and 395+ articles as hardcoded Dart constants. This is convenient for UI development but creates tight coupling between data and UI.

```dart
// Current — inside constitution_screen.dart
abstract final class MockConstitutionData {
  static const List<ConstitutionPart> parts = [ ... ];
}
```

### JSON Asset Structure (target)

```
assets/data/constitution/
    constitution_part_1.json
    constitution_part_2.json
    constitution_part_3.json
    ...
    constitution_part_22.json
    constitution_manifest.json
```

Each part JSON file follows this structure:

```json
{
  "id": "part_3",
  "number": "III",
  "name": "Fundamental Rights",
  "articles": [
    {
      "id": "a21",
      "number": "21",
      "title": "Protection of life and personal liberty",
      "is_preamble": false,
      "is_repealed": false,
      "is_omitted": false,
      "content": [
        {
          "type": "main",
          "text": "No person shall be deprived of his life or personal liberty except according to procedure established by law."
        }
      ],
      "case_law_ids": [
        "maneka_gandhi_v_uoi",
        "ak_gopalan_v_state_of_madras",
        "olga_tellis_v_bombay_municipal_corporation"
      ]
    }
  ]
}
```

`constitution_manifest.json` will list all part IDs so `JsonContentLoader` knows which files exist without hardcoding:

```json
{
  "parts": [
    "part_1", "part_2", "part_3", "part_4", "part_4a",
    "part_5", "part_6", "part_7", "part_8", "part_9",
    "part_9a", "part_9b", "part_10", "part_11", "part_12",
    "part_13", "part_14", "part_14a", "part_15", "part_16",
    "part_17", "part_18", "part_19", "part_20", "part_21", "part_22"
  ]
}
```

### Future implementation

```dart
// Future — constitution_repository_impl.dart
Future<List<ConstitutionPart>> loadAllParts() async {
  // 1. Load manifest to get part IDs
  final manifest = await _jsonLoader.loadConstitutionManifest();

  // 2. Load each part JSON (parallel for performance)
  final futures = manifest.parts
      .map((partId) => _jsonLoader.loadConstitutionPart(partId));
  final partJsonList = await Future.wait(futures);

  // 3. Map to domain models
  return partJsonList
      .map(ConstitutionPart.fromJson)
      .toList();
}

Future<ReaderContent> loadConstitutionArticle({
  required String partId,
  required String articleId,
}) async {
  final partJson    = await _jsonLoader.loadConstitutionPart(partId);
  final articleJson = _findArticle(partJson, articleId);
  if (articleJson == null) throw ContentNotFoundException(articleId);
  return ReaderContent.fromConstitutionArticleJson(articleJson, partId: partId);
}
```

### Migration checklist for Constitution

- [ ] Create `assets/data/constitution/constitution_part_N.json` for all 22 parts
- [ ] Create `assets/data/constitution/constitution_manifest.json`
- [ ] Add all constitution asset paths to `pubspec.yaml`
- [ ] Implement `JsonContentLoader.loadConstitutionPart(String partId)`
- [ ] Implement `JsonContentLoader.loadConstitutionManifest()`
- [ ] Implement `ReaderContent.fromConstitutionArticleJson()`
- [ ] Remove `MockConstitutionData` from `constitution_screen.dart`
- [ ] Create a dedicated `ConstitutionRepository` (do not keep data in the screen)

---

## Case Law Loading

### Current (mock)

Case laws are currently referenced only by ID inside section/article JSON. The actual case law content is either missing or hardcoded in `assets/data/case_laws/sample_case_laws.json` (5 sample entries).

### JSON Asset Structure (target)

```
assets/data/case_laws/
    maneka_gandhi_v_uoi.json
    ak_gopalan_v_state.json
    olga_tellis_v_bmc.json
    ...
    case_law_index.json
```

Each case law JSON follows this structure:

```json
{
  "id": "maneka_gandhi_v_uoi",
  "title": "Maneka Gandhi v. Union of India",
  "citation": "AIR 1978 SC 597",
  "court": "Supreme Court of India",
  "year": 1978,
  "bench": "7-Judge Constitutional Bench",
  "facts": "The petitioner's passport was impounded by the Government of India without giving any reason...",
  "issues": [
    "Whether the right to travel abroad is covered under Article 21.",
    "Whether the procedure established by law under Article 21 must be just, fair and reasonable."
  ],
  "judgment": "The Supreme Court held that the right to travel abroad is part of personal liberty under Article 21...",
  "reasoning": "The Court overruled A.K. Gopalan and held that Articles 14, 19 and 21 are not mutually exclusive...",
  "significance": "This case fundamentally expanded the interpretation of Article 21 and introduced the principle of substantive due process in Indian constitutional law.",
  "linked_articles": ["a21", "a14", "a19"],
  "linked_acts": [],
  "tags": ["Article 21", "Personal Liberty", "Due Process", "Passport"]
}
```

`case_law_index.json` enables fast lookup without loading every file:

```json
{
  "index": {
    "maneka_gandhi_v_uoi": {
      "title": "Maneka Gandhi v. Union of India",
      "year":  1978,
      "court": "Supreme Court of India"
    }
  }
}
```

### Future implementation

```dart
// Future — case_law_repository_impl.dart
Future<CaseLaw> getCaseLawById(String id) async {
  // 1. Load from asset (cached after first access)
  final json = await _jsonLoader.loadCaseLaw(id);

  // 2. Map to domain model
  return CaseLaw.fromJson(json);
}

Future<List<CaseLaw>> getCaseLawsByIds(List<String> ids) async {
  // Load all in parallel
  final futures = ids.map(getCaseLawById);
  return Future.wait(futures);
}
```

The `case_law_popup.dart` and `case_law_controller.dart` already expect this interface — no UI changes needed after migration.

### Migration checklist for Case Laws

- [ ] Create individual JSON files per case law under `assets/data/case_laws/`
- [ ] Create `assets/data/case_laws/case_law_index.json`
- [ ] Add case law asset paths to `pubspec.yaml`
- [ ] Implement `JsonContentLoader.loadCaseLaw(String id)`
- [ ] Implement `JsonContentLoader.loadCaseLawIndex()`
- [ ] Confirm `CaseLaw.fromJson()` matches JSON structure
- [ ] Remove sample_case_laws.json batch loader once individual files exist
- [ ] Update `case_law_repository_impl.dart` to use `JsonContentLoader`

---

## Academic Notes Loading

### Current (mock)

`AcademicNotesScreen` uses a hardcoded `Subject` list inside the screen file. No repository layer exists yet for academic content.

### JSON Asset Structure (target)

```
assets/data/academic/
    academic_years.json
    y1/
        subjects.json
    y2/
        subjects.json
    y3/
        subjects.json
    y4/
        subjects.json
    y5/
        subjects.json
```

`academic_years.json`:

```json
{
  "years": [
    { "id": "y1", "label": "First Year",  "subtitle": "Foundation of Law" },
    { "id": "y2", "label": "Second Year", "subtitle": "Core Law Subjects" },
    { "id": "y3", "label": "Third Year",  "subtitle": "Specialisation Begins" },
    { "id": "y4", "label": "Fourth Year", "subtitle": "Advanced Law" },
    { "id": "y5", "label": "Fifth Year",  "subtitle": "Final Year" }
  ]
}
```

`assets/data/academic/y1/subjects.json`:

```json
{
  "year_id": "y1",
  "subjects": [
    {
      "id":           "y1_jurisprudence",
      "title":        "Jurisprudence",
      "subtitle":     "Legal Theory and Philosophy",
      "pdf_path":     "assets/pdfs/y1/jurisprudence.pdf",
      "is_premium":   false,
      "is_available": true,
      "total_pages":  240
    },
    {
      "id":           "y1_contract",
      "title":        "Law of Contract",
      "subtitle":     "Indian Contract Act, 1872",
      "pdf_path":     "assets/pdfs/y1/law_of_contract.pdf",
      "is_premium":   false,
      "is_available": true,
      "total_pages":  310
    }
  ]
}
```

### Future implementation

```dart
// Future — academic_repository_impl.dart
Future<List<AcademicYear>> loadAllYears() async {
  final json  = await _jsonLoader.loadAcademicYearsManifest();
  return (json['years'] as List)
      .map((y) => AcademicYear.fromJson(y as Map<String, dynamic>))
      .toList();
}

Future<List<AcademicSubject>> loadSubjectsForYear(String yearId) async {
  final json     = await _jsonLoader.loadAcademicSubjects(yearId);
  final subjects = json['subjects'] as List;
  return subjects
      .map((s) => AcademicSubject.fromJson(s as Map<String, dynamic>))
      .toList();
}
```

### Migration checklist for Academic Notes

- [ ] Create `assets/data/academic/academic_years.json`
- [ ] Create `assets/data/academic/yN/subjects.json` for each year
- [ ] Add academic asset paths to `pubspec.yaml`
- [ ] Create `AcademicRepository` abstract class
- [ ] Implement `AcademicRepositoryImpl` with `JsonContentLoader`
- [ ] Create `AcademicYear` and `AcademicSubject` domain models with `fromJson`
- [ ] Add Riverpod providers for `academicYearsProvider` and `academicSubjectsProvider`
- [ ] Remove hardcoded `Subject` list from `academic_notes_screen.dart`
- [ ] Wire screen to new Riverpod providers

---

## JsonContentLoader — Implementation Reference

When implementing `JsonContentLoader`, follow this structure:

```dart
// lib/core/services/json_content_loader.dart

import 'dart:convert';
import 'package:flutter/services.dart';

abstract class JsonContentLoader {
  Future<Map<String, dynamic>> loadAct(String actId);
  Future<Map<String, dynamic>> loadConstitutionPart(String partId);
  Future<Map<String, dynamic>> loadConstitutionManifest();
  Future<Map<String, dynamic>> loadCaseLaw(String caseLawId);
  Future<Map<String, dynamic>> loadCaseLawIndex();
  Future<Map<String, dynamic>> loadAcademicYearsManifest();
  Future<Map<String, dynamic>> loadAcademicSubjects(String yearId);
}

class AssetJsonContentLoader implements JsonContentLoader {
  // ── In-memory cache: asset path → parsed JSON ──
  final Map<String, Map<String, dynamic>> _cache = {};

  Future<Map<String, dynamic>> _load(String assetPath) async {
    if (_cache.containsKey(assetPath)) return _cache[assetPath]!;
    final raw    = await rootBundle.loadString(assetPath);
    final parsed = json.decode(raw) as Map<String, dynamic>;
    _cache[assetPath] = parsed;
    return parsed;
  }

  @override
  Future<Map<String, dynamic>> loadAct(String actId) =>
      _load('assets/data/acts/$actId.json');

  @override
  Future<Map<String, dynamic>> loadConstitutionPart(String partId) =>
      _load('assets/data/constitution/constitution_$partId.json');

  @override
  Future<Map<String, dynamic>> loadConstitutionManifest() =>
      _load('assets/data/constitution/constitution_manifest.json');

  @override
  Future<Map<String, dynamic>> loadCaseLaw(String caseLawId) =>
      _load('assets/data/case_laws/$caseLawId.json');

  @override
  Future<Map<String, dynamic>> loadCaseLawIndex() =>
      _load('assets/data/case_laws/case_law_index.json');

  @override
  Future<Map<String, dynamic>> loadAcademicYearsManifest() =>
      _load('assets/data/academic/academic_years.json');

  @override
  Future<Map<String, dynamic>> loadAcademicSubjects(String yearId) =>
      _load('assets/data/academic/$yearId/subjects.json');
}
```

Key design decisions:
- `abstract class` interface means the repository never depends on the concrete loader
- In-memory `_cache` means each JSON file is only read from disk once per app session
- All paths are in one place — easy to update if the asset structure changes
- Can be swapped in tests with a `MockJsonContentLoader` that returns test fixtures

---

## Future Scalability Considerations

### 1. Content versioning

As Law Briefly grows, JSON content will need versioning to handle amendments and updates to existing Acts and the Constitution. A `content_version.json` file should track the version of each content file:

```json
{
  "bns_2023":     "1.2.0",
  "constitution": "2.0.1",
  "case_laws":    "1.0.4"
}
```

### 2. Remote content delivery

The current architecture bundles all JSON inside the app APK. For large content libraries, this increases APK size significantly. The future approach is:

```
Phase 1 (current):   Bundle JSON in APK assets
Phase 2 (planned):   Download JSON from CDN on first launch, cache locally
Phase 3 (future):    Incremental updates — only re-download changed files
```

`JsonContentLoader` is already abstracted, so Phase 2 requires only a new implementation (`RemoteJsonContentLoader`) — the repository layer and UI need zero changes.

### 3. Full-text search

Once content moves to JSON files, full-text search across all Acts and Constitution becomes possible. A search index (generated at build time or downloaded separately) can be added without changing the repository contract:

```dart
// Future addition to JsonContentLoader
Future<List<SearchResult>> search(String query);
```

### 4. Offline-first guarantees

The current in-memory cache satisfies offline-first for the app session. For true offline persistence across sessions, the JSON cache should be written to `getApplicationDocumentsDirectory()` after first download. The existing `IsarDatabaseService` infrastructure already supports this.

### 5. Content modularisation

As the content library grows (all 22 parts, 400+ articles, 25+ Acts, 500+ case laws), loading everything at startup would be slow. The correct approach is lazy loading by module:

```
App start          → load manifest files only (fast, ~10KB)
User opens Acts    → load act list index (~50KB)
User opens BNS     → load bns_2023.json (~200KB) and cache it
User reads section → extract section from cached JSON (instant)
```

This pattern is already implied by `JsonContentLoader`'s per-file loading design.

### 6. Marketplace architecture readiness

Law Briefly's planned marketplace feature (premium content packs, state law modules, exam notes) maps naturally onto this architecture:

```
Free content:     bundled in APK / downloadable for free
Premium content:  purchased → downloaded → cached locally → loaded via JsonContentLoader
```

The `is_premium` flag already exists in the Academic Notes subject model. The same pattern extends to Acts and Case Law packs.

---

## Summary

| Module | Current State | Target State | Breaking Change? |
|---|---|---|---|
| Acts | Hardcoded mock | `assets/data/acts/*.json` | No — repo interface stays same |
| Constitution | Hardcoded in screen | `assets/data/constitution/*.json` | No — move data out of screen |
| Case Laws | 5 sample JSON entries | Individual JSON per case law | No — loader already abstracted |
| Academic Notes | Hardcoded in screen | `assets/data/academic/*.json` | No — add repository layer |

In every case: the UI layer does not need to change. Only the repository implementation changes. This is the value of the clean architecture already in place.

---

*End of document.*
