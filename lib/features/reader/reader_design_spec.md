# Reader Screen — Design Specification
## Law Briefly — The Reading Experience

**File:** `lib/features/reader/reader_design_spec.md`  
**Last Updated:** June 2026  
**Status:** Active — production design reference  
**Author:** Law Briefly Design & Architecture Team

---

## Philosophy

The Reader Screen is the most important screen in Law Briefly.

Every other screen — Home, Acts, Constitution, Bookmarks — exists to get the student to the Reader. The Reader is where the actual learning happens. It must earn and hold a student's trust for hours at a time.

The design is inspired by three of the best reading experiences ever built:

**Apple Books** — for its typographic restraint, generous whitespace, and the feeling that the UI disappears and only the words remain.

**Kindle** — for its obsessive focus on reading comfort over long sessions, its respect for the reader's concentration, and its understanding that every pixel of chrome is a pixel stolen from content.

**Premium legal publications** — for their use of serif typography, structured hierarchy, and the gravitas that serious legal text deserves.

The Reader must feel like a premium legal study tool. Not a note-taking app. Not a browser. A dedicated reading environment built specifically for Indian law students who need to spend hours with dense statutory text.

---

## Design Goals

### 1. Maximum readability

Every typographic decision — font choice, size, weight, line height, paragraph spacing, line length — is optimised for comprehension, not aesthetics. Georgia is used for all legal content because it is a screen-optimised serif that has been proven in high-volume reading applications since 1993. Serif fonts reduce eye strain for long-form text by giving the eye horizontal guides to follow across each line.

The content column is constrained to a maximum width of 680 logical pixels — matching the optimal measure (line length) for comfortable reading. On wide screens, side margins increase before the content column grows. This mirrors how premium print publications use wide margins rather than stretching text across the full page.

### 2. Long reading comfort

A law student reading a full Act chapter may spend 45–90 minutes in the Reader without leaving. The design must sustain this.

Line height is set to 1.78 — significantly more generous than default Flutter text rendering. This gives each line of text room to breathe, reducing the visual density that causes eye fatigue. Paragraph spacing of 20 logical pixels creates clear visual separation between provisions without requiring the reader to consciously parse where one thought ends and another begins.

The background in light mode is `#FFFEEA` — a warm off-white, not pure white. Pure white (`#FFFFFF`) at full brightness causes glare on high-resolution OLED displays. The warm tint reduces eye strain for extended reading sessions, mimicking the paper-like quality that made Kindle's original e-ink display so comfortable.

### 3. Minimal distractions

The Reader operates in a state of maximum focus. The only UI elements visible during reading are:

- The glass app bar (semi-transparent, minimal)
- The section number badge
- The section title
- The legal text
- The case laws section (below content)
- The bottom navigation bar

There are no floating action buttons, no side drawers, no tab bars, no notifications, no bottom sheets competing for attention. The student opens the Reader and the world outside disappears.

The glass app bar and bottom navigation bar blur the content behind them using `ImageFilter.blur` — the content continues to exist, it is simply softened, reinforcing the sense of depth and focus without hard visual interruptions.

### 4. Fast navigation

Moving between sections and articles must feel instantaneous. The bottom navigation bar's Previous and Next buttons are large touch targets — not small icon buttons requiring precise tapping. They sit at thumb height in a fixed floating bar, reachable without shifting grip.

The Reader uses `BouncingScrollPhysics` to give scrolling a natural momentum feel. When the student reaches the end of a section and taps Next, the new section loads and the scroll position resets to the top — the reader begins fresh.

### 5. Professional legal study feel

The Reader must communicate seriousness. Law is serious. Students studying for their LLB and LLM examinations are preparing for a profession of consequence.

This seriousness is communicated through:

- Georgia serif typography — the font of legal documents and premium legal publications
- Deep navy accent colour (`#1C4ED8`) for interactive elements — authoritative, not playful
- Gold (`#D4AF37`) for proviso markers and preamble — the colour of legal seals and judicial robes
- Conservative use of colour — text is predominantly dark on light, with colour used only to signal meaning (accent for interactive, gold for proviso, accent light for article number)
- Generous whitespace — space is not empty; it is respect for the content

---

## Layout Architecture

```
┌────────────────────────────────────────────────────────┐
│                    STATUS BAR                          │
├────────────────────────────────────────────────────────┤
│              GLASS APP BAR (blurred)                   │
│  ← Back    Section 103 · Bharatiya Nyaya Sanhita       │
└────────────────────────────────────────────────────────┘
│                                                        │
│  ┌──────────────────────────────────────────────────┐  │
│  │  Section 103                    ← Number Badge   │  │
│  └──────────────────────────────────────────────────┘  │
│                                                        │
│  Theft                              ← Section Title    │
│                                                        │
│  Whoever, intending to take dishonestly any moveable   │
│  property out of the possession of any person...       │
│                                     ← Body Text        │
│                                                        │
│  (1) Explanation — A thing so long as it is attached   │
│  to the earth, not being moveable property, is not...  │
│                     ← Explanation block (indented)     │
│                                                        │
│  Provided that where the accused... ← Proviso block    │
│                                                        │
│  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─  ← Subtle Divider  │
│                                                        │
│  ⚖  Linked Case Laws  [3]           ← Section Header  │
│                                                        │
│  → K.N. Mehra v. State of Rajasthan      >            │
│  → Pyare Lal v. State of Delhi           >            │
│  → State of Maharashtra v. Vishwanath    >            │
│                                                        │
│                                                        │
│                                                        │
├────────────────────────────────────────────────────────┤
│         BOTTOM NAVIGATION BAR (floating, glass)        │
│  ← Previous      🔖 Bookmark       Next →              │
└────────────────────────────────────────────────────────┘
```

---

## Typography System

All typographic values are defined in `AppReader` inside `lib/core/theme/app_theme.dart`.

```dart
abstract final class AppReader {
  static const double maxWidth          = 680;
  static const double lineHeight        = 1.78;
  static const double sideMargin        = 20;
  static const double baseFontSize      = 16;
  static const double titleFontSize     = 22;
  static const double paragraphSpacing  = 20;
}
```

---

### Section / Article Number Badge

```
┌──────────────────────┐
│   Section 103        │
└──────────────────────┘
```

**Purpose:** Immediately orients the student. Before reading a single word of content, the student knows exactly which section or article they are in.

| Property | Value | Rationale |
|---|---|---|
| Font | Georgia | Legal document feel |
| Size | 11.5pt | Compact — supporting role |
| Weight | Bold (700) | Must read instantly |
| Color | Accent (`#1C4ED8` dark, `#acccf7` light mode) | Interactive accent signals "you are here" |
| Letter spacing | 0.2 | Opens up the label slightly for legibility at small size |
| Background | Accent at 9–14% opacity | Soft pill — visible but not dominant |
| Border | Accent at 28% opacity, 0.5px | Subtle definition |
| Padding | 10px horizontal, 4px vertical | Comfortable pill shape |
| Border radius | Chip radius (100px) | Pill shape — modern, not boxy |

For the Preamble, the badge displays "Preamble" instead of "Article Preamble", respecting the document's own terminology.

---

### Section / Article Title

```
Theft
```

**Purpose:** The title is the student's anchor. While body text may run many paragraphs, the title remains fixed in memory as the conceptual frame for everything being read.

| Property | Value | Rationale |
|---|---|---|
| Font | Georgia | Legal serif — match body |
| Size | 22pt | Significantly larger than body — clear hierarchy |
| Weight | Bold (700) | Strongest weight in the reader |
| Color | Primary text | Full contrast — no tinting |
| Letter spacing | -0.2 | Tighter tracking improves headline legibility at this size |
| Line height | 1.35 | Tighter than body — titles are short, need density |
| Top margin | 16px below badge | Breathing room between badge and title |
| Bottom margin | 24px | Generous space before body text begins |

---

### Body Text (Main Content)

```
Whoever, intending to take dishonestly any moveable property out 
of the possession of any person without that person's consent...
```

**Purpose:** This is the primary reading surface. Every decision prioritises sustained comfort over 45–90 minute reading sessions.

| Property | Value | Rationale |
|---|---|---|
| Font | Georgia | Proven serif for screen legal reading |
| Size | 16pt | Optimal for mobile reading at arm's length |
| Weight | Regular (400) | Body text must not compete with title |
| Color | Primary text | Full contrast — no opacity reduction |
| Line height | 1.78 | Generous — reduces line crowding fatigue |
| Letter spacing | 0.10 | Slight opening improves legal text legibility |
| Paragraph spacing | 20px bottom | Clear separation between provisions |
| Max column width | 680px | Optimal measure — prevents excessively long lines |

---

### Explanation Blocks

```
│  Explanation — A thing so long as it is attached to the earth,
│  not being moveable property, is not the subject of theft...
```

**Purpose:** Explanations in Acts clarify definitions and scope. They are subordinate to the main provision but critically important for interpretation. They must be visually distinct without being distracting.

| Property | Value | Rationale |
|---|---|---|
| Left margin | 20px indent | Signals subordination |
| Left border | 3px, accent at 45% opacity | The defining visual signature of an explanation |
| Left padding | 12px | Space between border and text |
| Font | Georgia italic | Italic signals a different register — explanatory mode |
| Size | 14.5pt | Slightly smaller than main body — supporting role |
| Line height | 1.78 | Same as body — no disruption to rhythm |
| Label style | Bold italic, accent color | "Explanation —" label is navigational |

---

### Proviso Blocks

```
│  Provided that where the accused person is the owner of 
│  the property, the offence of theft is not committed...
```

**Purpose:** Provisos limit or qualify the main provision. In legal text, "Provided that" is a technical term with precise meaning. The design signals this technical distinction with a different accent colour from explanations.

| Property | Value | Rationale |
|---|---|---|
| Left margin | 20px indent | Same as explanation — same structural level |
| Left border | 3px, gold (`#D4AF37`) at 55% opacity | Gold distinguishes provisos from explanations |
| Left padding | 12px | Consistent with explanation |
| Font | Georgia italic | Same register as explanation |
| Size | 14.5pt | Same as explanation |
| Label style | Bold italic, gold | "Provided that —" label in gold reinforces the distinction |

The gold colour for provisos is a considered choice. Gold is associated with legal authority — judicial seals, bar association crests, Supreme Court insignia. Using it for provisos elevates their visual importance while distinguishing them from explanations.

---

### Sub-Section Text

Sub-sections (clauses `(a)`, `(b)`, `(c)`) are indented 16px from the left margin. They use the same Georgia font and 16pt size as body text but carry a 10% opacity reduction to signal their subordinate relationship to the parent provision. Line height and letter spacing are identical to body — reading rhythm is never broken.

---

## Glass App Bar

```
┌─────────────────────────────────────────────────────────────┐
│ [←]    Section 103              Bharatiya Nyaya Sanhita     │
└─────────────────────────────────────────────────────────────┘
     ↑ Back    ↑ Content ID (accent)   ↑ Source (secondary)
```

The app bar uses the project-wide `GlassAppBar` component with `ImageFilter.blur(sigmaX: 14, sigmaY: 14)` — medium blur that softens the content scrolling behind it without obscuring the bar's own content.

**Title area (centre):**
- Line 1: Section or article label in accent colour, bold — `"Section 103"` or `"Article 21"`
- Line 2: Source name in secondary text, 10pt — `"Bharatiya Nyaya Sanhita, 2023"` or `"Constitution of India"`

This two-line title gives the student continuous orientation. At any point during reading, looking up at the bar confirms both which provision they are on and which source it belongs to.

**Back button (leading):**
Circular glass button, 34px diameter. `Icons.arrow_back_ios_rounded` at 15pt. Tap pops the navigator. Scale animation on press (0.88 scale) provides immediate tactile feedback.

**No trailing actions in the bar.**
The reader does not need search, share, or settings buttons visible during reading. These distract. The only actions the reader needs are in the bottom navigation bar where thumbs naturally rest.

---

## Case Laws Section

The case laws section appears at the bottom of the content scroll, below all provisions. It is revealed as the student scrolls through the content — a reward for reading to the end of the section, not a distraction interrupting the reading flow.

```
── ── ── ── ── ── ── ── ── ── ── ── ── ── ── ── ──  ← Gradient divider

⚖  Linked Case Laws   [3]                           ← Section header

→  K.N. Mehra v. State of Rajasthan          >
→  Pyare Lal v. State of Delhi               >
→  State of Maharashtra v. Vishwanath        >
```

### Divider

A gradient horizontal line — transparent at both ends, transitioning to 60% opacity at centre. This is softer and more elegant than a hard divider, consistent with the glass aesthetic throughout the app. The divider signals "content ends here, related material begins" without a jarring break.

### Section header

```
⚖  Linked Case Laws   [3]
```

- Gavel icon (`Icons.gavel_rounded`) at 14pt in secondary text colour
- Label "Linked Case Laws" at 12pt, 0.5 letter spacing, secondary text colour
- Count badge — small pill, secondary colour at 12% opacity, bold count inside
- No title-level weight — this is supporting content

### Case law rows

Each case law is a tappable row:

```
→  K.N. Mehra v. State of Rajasthan                     >
```

- `Icons.arrow_right_rounded` at 18pt, accent at 60% opacity — subtle lead-in
- Case title in Georgia italic, 14pt, secondary text colour — italic signals this is a citation
- Trailing chevron `>` at 14pt — signals tappability
- Press state: accent colour at 6% background — gentle acknowledgment of touch
- Tap action: `showCaseLawPopup(context, caseLawId)`

The italic treatment for case titles is a deliberate legal convention. Legal citations have always been italicised in print — the design respects and continues this tradition.

---

## Case Law Modal

Tapping a case law row triggers `showCaseLawPopup()`, which presents a glass bottom sheet modal.

```
┌────────────────────────────────────────────────────────┐
│                    DRAG HANDLE                         │
├────────────────────────────────────────────────────────┤
│                                                        │
│  Maneka Gandhi v. Union of India          AIR 1978 SC  │
│  Supreme Court of India · 1978                         │
│                                                        │
│  ─────────────────────────────────────────             │
│                                                        │
│  FACTS                                                 │
│  The petitioner's passport was impounded...            │
│                                                        │
│  ISSUES                                                │
│  1. Whether the right to travel abroad...              │
│  2. Whether the procedure established...               │
│                                                        │
│  JUDGMENT                                              │
│  The Supreme Court held that...                        │
│                                                        │
│  REASONING                                             │
│  The Court overruled A.K. Gopalan and held...          │
│                                                        │
│  SIGNIFICANCE                                          │
│  This case fundamentally expanded...                   │
│                                                        │
└────────────────────────────────────────────────────────┘
```

### Modal dimensions

| Property | Value | Rationale |
|---|---|---|
| Initial height | 80% of screen height | Enough to read without expanding |
| Maximum height | 90% of screen height | Near-full-screen for long judgments |
| Minimum height | 50% | Allows partial view as drag handle is visible |
| Border radius (top) | 28px | Consistent with app-wide dialog radius |
| Backdrop blur | 20px | Full glass effect — content is blurred behind |

### Modal content structure

**Header (fixed, not scrollable):**

```
Maneka Gandhi v. Union of India                AIR 1978 SC 597
Supreme Court of India · 1978
```

- Case name: Georgia, 18pt, bold, primary text
- Citation: 11pt, accent colour, trailing right-aligned
- Court and year: 13pt, secondary text
- Horizontal divider below header

**Scrollable body:**

Each section uses a consistent pattern:

```
FACTS
───────
The petitioner's passport was impounded by the Government 
of India without giving any reason. She filed a writ 
petition challenging the impoundment...
```

Section labels:
- Font: System font (UI label, not legal text)
- Size: 10.5pt
- Weight: Bold (700)
- Color: Secondary text
- Letter spacing: 1.2px — wide tracking signals a label, not content
- Margin below: 6px

Section content:
- Font: Georgia
- Size: 15pt
- Line height: 1.72
- Color: Primary text

The Issues section renders as a numbered list. Each issue is on its own line, preceded by its number. This matches how issues are presented in law school case notes — the student immediately recognises the format.

**Scrolling:**
`BouncingScrollPhysics` inside the modal, consistent with the main reader. Smooth, natural, reading-first.

**Close:**
Drag the sheet down past 30% of its height to dismiss. No explicit close button — the drag handle communicates dismissability. This matches iOS bottom sheet conventions that students are familiar with from Apple Books and other native apps.

---

## Bottom Navigation Bar

The bottom navigation bar is a floating glass pill fixed above the safe area, horizontally padded from screen edges.

```
┌──────────────────────────────────────────────────────────┐
│  ← Previous        🔖 Bookmark            Next →         │
└──────────────────────────────────────────────────────────┘
```

### Container styling

| Property | Value |
|---|---|
| Height | 64px |
| Border radius | 100px (full pill) |
| Backdrop blur | 20px (xl blur) |
| Background | Dark: `#1C1C1E` at 85% opacity / Light: `#FFFFFF` at 87.5% opacity |
| Border | 0.5px, white at 15% (dark) or 20% (light) opacity |
| Shadow | Black at 38% (dark) or 10% (light), 28px blur, 10px Y offset |
| Position | Fixed, 24px above safe area bottom edge |

### Previous button

- Width: 94px touch target (deliberately large)
- Label: "Previous" at 12pt, semibold
- Icon: `Icons.arrow_back_ios_rounded` at 16pt
- Layout: Icon leading, label trailing
- Disabled state: 28% opacity — clearly not available, not confusing
- Enabled state: Full primary text colour
- Press state: 42% opacity — immediate feedback
- Tap action: `readerController.loadPrevious()`
- Haptic: `HapticFeedback.lightImpact()` on tap

### Bookmark button (centre)

The bookmark button is the most important persistent action in the Reader. A student who finds a section worth saving should be able to bookmark it with one thumb tap without breaking reading flow.

**States:**

```
Not bookmarked:    🔖  Bookmark      (secondary color)
Bookmarked:        🔖  Saved         (accent color)
Toggling:          ◌   [spinner]     (accent color)
```

| Property | Value |
|---|---|
| Icon (not bookmarked) | `Icons.bookmark_border_rounded`, 24pt, secondary |
| Icon (bookmarked) | `Icons.bookmark_rounded`, 24pt, accent |
| Label (not bookmarked) | "Bookmark", 10pt, tertiary |
| Label (bookmarked) | "Saved", 10pt, accent |
| State transition | `AnimatedSwitcher` 220ms, scale + fade |
| Loading state | `CircularProgressIndicator`, 20px, 2px stroke, accent |
| Tap action | Toggle via `bookmarkControllerProvider` |
| Data source | `isBookmarkedProvider(content.id)` — Isar-backed |
| Haptic | `HapticFeedback.mediumImpact()` on toggle |

The bookmark state is read from Isar on every Reader screen load — it reflects the true persisted state, not an optimistic local toggle. The `AnimatedSwitcher` transition between states (empty bookmark → filled bookmark) is smooth and satisfying — it makes bookmarking feel like an action of consequence.

### Next button

Mirror of Previous button:
- Width: 94px touch target
- Label: "Next" at 12pt, semibold
- Icon: `Icons.arrow_forward_ios_rounded` at 16pt
- Layout: Label leading, icon trailing
- Tap action: `readerController.loadNext()`

---

## Scroll Behaviour

Smooth, reading-first scrolling is non-negotiable. The Reader uses `SingleChildScrollView` with `BouncingScrollPhysics` — the iOS-native bouncing physics that feels organic rather than the abrupt stops of `ClampingScrollPhysics`.

### Why BouncingScrollPhysics

`ClampingScrollPhysics` (Android default) stops abruptly at content boundaries. This feels mechanical and interrupts the reading state. `BouncingScrollPhysics` continues slightly past the boundary and springs back — a natural deceleration that matches how physical books behave when you reach the bottom of a page.

Law students reading on the train or between lectures deserve the same quality of reading experience they get from Apple Books. `BouncingScrollPhysics` is a meaningful contributor to that quality.

### Content padding

```dart
EdgeInsets.fromLTRB(
  AppReader.sideMargin,                    // 20px left
  topPad + kToolbarHeight + AppSpacing.xl, // Top: safe area + bar + 24px
  AppReader.sideMargin,                    // 20px right
  botPad + 96,                             // Bottom: safe area + nav bar clearance
)
```

The bottom padding of `botPad + 96` ensures the last paragraph of content is never obscured by the floating bottom navigation bar. The student can always scroll to read the final word of a section.

### Scroll position on section change

When Previous or Next is tapped and a new section loads, the `ScrollController` does not animate to top — the `ReaderContent` state change triggers a widget rebuild which naturally resets the scroll position. This is intentional: each new section begins fresh at the top, not mid-scroll from the previous section.

---

## Entrance Animations

The Reader screen uses a choreographed entrance animation sequence. This serves two purposes: it gives the content time to load from the repository while showing a skeleton, and it signals to the student that they have entered a dedicated reading space.

```
Timeline (800ms total):

0ms  ──────── App bar begins fading + sliding down
              [0ms → 360ms, easeOut]

160ms ─────── Content begins fading + rising
              [160ms → 600ms, easeOut]

440ms ─────── Bottom nav bar rises from below screen
              [440ms → 800ms, easeOutCubic]
```

The staggered timing means the student sees the app bar first (orientation), then the content (the thing they came for), then the navigation bar (the tools they might need). This is the natural reading-first priority order.

### Loading skeleton

While content loads, the Reader shows an animated skeleton:

- Pulsing opacity animation (35% → 85%, 1400ms, repeat reverse)
- Number badge skeleton: 80×24px rounded rectangle
- Title skeleton: two lines (full width + 240px), 20px height each
- Body skeleton: 8 lines, alternating full width and 200px, 14px height each

The skeleton matches the approximate layout of real content so the transition from loading to loaded feels seamless rather than jarring.

---

## Loading, Error, and Idle States

### Loading state

Skeleton animation as described above. No spinner — spinners communicate "waiting for network". The skeleton communicates "content is being prepared" — which is accurate (loading from local asset JSON) and implies immediacy.

### Error state

```
┌─────────────────────────────────────────┐
│                                         │
│          [Error icon, 64×64]           │
│                                         │
│        Content Unavailable             │
│                                         │
│    The section could not be loaded.    │
│                                         │
│         [  Try Again  ]                │
│                                         │
└─────────────────────────────────────────┘
```

- Error icon container: 64×64, error red at 8–14% opacity background
- Title: "Content Unavailable", titleMedium, bold
- Message: body text, secondary colour, max 3 lines
- Retry button: accent gradient fill, full pill, "Try Again" with refresh icon

### Idle state

Shown when the Reader is opened without a section or article specified (should not happen in normal navigation, but handled gracefully):

- Centered column layout
- Article outline icon at 56pt, 50% opacity
- Body text: "Open a section or article to begin reading." — Georgia italic, secondary text

---

## Dark Mode

The Reader fully supports dark mode. All colours adapt:

| Element | Light mode | Dark mode |
|---|---|---|
| Background | `#FFFEEA` (warm off-white) | `#0D1117` (deep dark) |
| Primary text | Near-black | Near-white |
| Secondary text | Medium grey | Light grey |
| Accent | `#1C4ED8` (deep blue) | `#93C5FD` (lighter blue) |
| Gold (proviso) | `#D4AF37` | `#D4AF37` (same — gold works on both) |
| App bar | White at 87% + blur | Dark at 85% + blur |
| Bottom nav | White at 87% + blur | Dark at 85% + blur |

The dark mode background `#0D1117` is slightly blue-tinted rather than pure black. Pure black (`#000000`) on OLED displays creates harsh contrast that causes halos around white text — the bane of long reading sessions. The slight blue tint softens this while maintaining excellent contrast.

---

## Accessibility

### Touch targets

Every interactive element in the Reader meets or exceeds Apple's 44×44pt minimum touch target recommendation:

| Element | Touch target |
|---|---|
| Back button | 34×34px + gesture area |
| Previous button | 94×64px |
| Bookmark button | Expanded touch area, 64px height |
| Next button | 94×64px |
| Case law row | Full row width, 48px minimum height |
| Modal drag handle | Full sheet width, 32px height |

### Text selection

The Reader wraps all legal content in `SelectionArea` — students can select text to copy provisions, share with classmates, or paste into their notes. This is a deliberate study workflow consideration.

### Text scale

The app clamps text scaling between 0.85 and 1.20 in `main.dart`. This respects system font size preferences without allowing extreme scaling that would break the carefully tuned typographic hierarchy.

---

## Design Constants Reference

All values implemented in `lib/core/theme/app_theme.dart`:

```dart
// Reader-specific constants
abstract final class AppReader {
  static const double maxWidth         = 680;  // Max content column width
  static const double lineHeight       = 1.78; // Body text line height
  static const double sideMargin       = 20;   // Horizontal content padding
  static const double baseFontSize     = 16;   // Body text size
  static const double titleFontSize    = 22;   // Section/article title size
  static const double paragraphSpacing = 20;   // Space between content blocks
}

// Blur constants used in Reader
abstract final class AppBlur {
  static const double md = 14; // App bar blur
  static const double xl = 20; // Bottom nav + modal blur
}

// Spacing used in Reader
abstract final class AppSpacing {
  static const double sm   = 8;
  static const double base = 16;
  static const double xl   = 24;
  static const double xxxl = 40;
  static const double max  = 80;
}
```

---

## Implementation Files

| File | Role |
|---|---|
| `lib/features/reader/reader_screen.dart` | Main screen — layout, animations, state |
| `lib/features/reader/case_law_popup.dart` | Glass modal for case law detail |
| `lib/features/reader/models/reader_content.dart` | Domain model for loaded content |
| `lib/features/reader/models/reader_state.dart` | Immutable state for the reader |
| `lib/features/reader/providers/reader_controller.dart` | StateNotifier — load/navigate logic |
| `lib/features/reader/providers/case_law_controller.dart` | FutureProvider for case law data |
| `lib/features/reader/data/reader_repository.dart` | Abstract repository contract |
| `lib/features/reader/data/reader_repository_impl.dart` | Concrete implementation |
| `lib/features/bookmarks/providers/bookmark_provider.dart` | Bookmark state — `isBookmarkedProvider` |
| `lib/core/theme/app_theme.dart` | All design constants including AppReader |

---

## Design Principles Summary

| Principle | How it is applied |
|---|---|
| Content first | Glass bars blur, never block. Navigation is at thumb height, not reading height. |
| Typographic hierarchy | Three clear levels: number badge → title → body. Each unambiguous. |
| Earned colour | Colour is used to signal meaning — accent for interactive, gold for proviso, not decoration. |
| Reading rhythm | Line height 1.78, paragraph spacing 20px, side margins 20px. Rhythm is never broken. |
| Touch respect | All targets 44px+. Thumb-reachable navigation. No precision tapping required. |
| State legibility | Loading → skeleton. Error → clear message + retry. Bookmarked → filled icon. All states are unambiguous. |
| Legal respect | Georgia serif, gold proviso markers, constrained column width. The design honours the seriousness of legal text. |

---

*End of document.*
