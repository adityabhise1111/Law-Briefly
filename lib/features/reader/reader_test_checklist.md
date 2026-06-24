# Reader Screen — Test Checklist
## Law Briefly — Manual QA Verification Guide

**File:** `lib/features/reader/reader_test_checklist.md`  
**Last Updated:** June 2026  
**Status:** Active — run before every APK build  
**Tester:** ___________________  
**Device:** ___________________  
**Android Version:** ___________________  
**Build Number:** ___________________  
**Date Tested:** ___________________

---

## How to Use This Checklist

Work through every test in order on a physical Android device.  
Do not test on an emulator for scroll and animation verification — use real hardware.  
Run in both **light mode** and **dark mode** for every section.

Mark each test:
- `[x]` — Pass
- `[!]` — Fail — describe the failure in the notes field
- `[-]` — Skipped — note reason

**Minimum pass requirement:** All 🔴 items must pass before the build is shared.

---

## Test Setup

Before starting, complete the following:

- [ ] Device has sufficient storage (minimum 100MB free)
- [ ] App is freshly installed (not updated over an old install)
- [ ] Device is in portrait orientation
- [ ] Device brightness is at 50–75%
- [ ] System font size is at default (no accessibility overrides)
- [ ] Test begins with a valid session active (logged in or guest)
- [ ] At least one Act with sections is available in JSON assets
- [ ] At least one Constitution part with articles is available in JSON assets
- [ ] At least one case law entry exists in case laws JSON

---

## 1. Reader Opens Correctly

### 1.1 Open via Act Section

**Test path:** Home → Acts → Select any Act → Select any Chapter → Tap any Section

- [ ] 🔴 ActDetail screen opens without crash
- [ ] 🔴 Tapping a section navigates to Reader screen
- [ ] 🔴 Reader screen appears — no blank screen, no white flash
- [ ] 🔴 Skeleton loading state appears if content takes time to load
- [ ] 🔴 Content replaces skeleton — no layout jump on transition
- [ ] 🔴 App bar is visible immediately
- [ ] 🔴 Back button is visible in app bar leading position
- [ ] 🔴 Bottom navigation bar is visible at screen bottom

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 1.2 Open via Constitution Article

**Test path:** Home → Constitution → Select any Part → Tap any Article

- [ ] 🔴 Constitution screen opens without crash
- [ ] 🔴 Tapping an article navigates to Reader screen
- [ ] 🔴 Reader screen appears — no blank screen, no white flash
- [ ] 🔴 Skeleton loading state appears if content takes time to load
- [ ] 🔴 Content replaces skeleton — smooth transition
- [ ] 🔴 App bar is visible immediately
- [ ] 🔴 Back button is visible in app bar leading position
- [ ] 🔴 Bottom navigation bar is visible at screen bottom

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 1.3 Entrance Animation

- [ ] 🔴 App bar fades in from transparent — animation is smooth, not instant
- [ ] 🔴 App bar slides down from above — visible slide motion
- [ ] 🔴 Content area fades in after app bar begins
- [ ] 🔴 Bottom navigation bar rises from below screen edge
- [ ] 🔴 All three animations complete within approximately 1 second
- [ ] 🔴 No animation jank or stutter on this device
- [ ] 🔴 Animations do not replay when scrolling

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

## 2. Section Content Displays

**Test path:** Reader opened via any Act Section

### 2.1 App Bar Content

- [ ] 🔴 App bar shows section identifier in accent colour (e.g. "Section 103")
- [ ] 🔴 App bar shows act name in smaller secondary text below section identifier
- [ ] 🔴 App bar text is not truncated — full section label is readable
- [ ] 🔴 App bar background is semi-transparent glass — content visible scrolling behind it
- [ ] 🔴 App bar blur effect is active — content behind bar is blurred, not sharp

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 2.2 Section Number Badge

- [ ] 🔴 Section number badge appears at top of content area
- [ ] 🔴 Badge reads "Section X" format (e.g. "Section 103")
- [ ] 🔴 Badge background is accent colour at low opacity (pill shape)
- [ ] 🔴 Badge border is visible (subtle, 0.5px)
- [ ] 🔴 Badge text is accent colour, bold
- [ ] 🔴 Badge is fully readable — no text clipping

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 2.3 Section Title

- [ ] 🔴 Section title appears below number badge with visible spacing
- [ ] 🔴 Title uses Georgia serif font — visually distinct from system font
- [ ] 🔴 Title font size is noticeably larger than body text
- [ ] 🔴 Title weight is bold — heaviest weight visible in content area
- [ ] 🔴 Title colour is primary text (full contrast, not muted)
- [ ] 🔴 Title does not overlap number badge
- [ ] 🔴 Multi-line titles wrap correctly — no overflow or clipping

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 2.4 Body Text

- [ ] 🔴 Body text renders in Georgia serif font
- [ ] 🔴 Body text size is comfortable for reading (approximately 16pt)
- [ ] 🔴 Line height feels generous — lines are not tightly packed
- [ ] 🔴 Body text colour is high contrast against background
- [ ] 🔴 Text does not touch screen edges — side margins are present
- [ ] 🔴 No text is clipped by app bar at top
- [ ] 🔴 No text is clipped by navigation bar at bottom when scrolled to end

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 2.5 Content Block Types

**For a section containing explanation blocks:**

- [ ] 🔴 Explanation block is visually indented from main text
- [ ] 🔴 Left accent border (blue/accent coloured vertical line) is visible on explanation
- [ ] 🔴 Explanation text is italic
- [ ] 🔴 "Explanation —" label appears in accent colour above explanation text
- [ ] 🔴 Explanation block is clearly distinct from surrounding main text

**For a section containing proviso blocks:**

- [ ] 🔴 Proviso block is visually indented from main text
- [ ] 🔴 Left gold border (gold coloured vertical line) is visible on proviso
- [ ] 🔴 Proviso text is italic
- [ ] 🔴 "Provided that —" label appears in gold above proviso text
- [ ] 🔴 Proviso left border colour is visually different from explanation left border

**For a section containing sub-sections:**

- [ ] 🔴 Sub-sections are indented from main body text
- [ ] 🔴 Sub-section text is slightly lighter/more muted than main body
- [ ] 🔴 Sub-sections read as part of the provision — not visually separated

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

## 3. Article Content Displays

**Test path:** Reader opened via any Constitution Article

### 3.1 App Bar Content

- [ ] 🔴 App bar shows article identifier in accent colour (e.g. "Article 21")
- [ ] 🔴 App bar shows "Constitution of India" in smaller secondary text
- [ ] 🔴 Preamble shows "Preamble" not "Article Preamble"
- [ ] 🔴 App bar glass effect is active

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 3.2 Article Number Badge

- [ ] 🔴 Badge reads "Article X" format (e.g. "Article 21")
- [ ] 🔴 Preamble badge reads "Preamble" (not "Article Preamble" or "Article Preamble")
- [ ] 🔴 Badge styling matches section number badge (same pill shape, accent colour)
- [ ] 🔴 Repealed articles display correctly — badge shows article number
- [ ] 🔴 Omitted articles display correctly — badge shows article number

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 3.3 Article Title

- [ ] 🔴 Article title is correct for the selected article
- [ ] 🔴 Long article titles wrap to multiple lines without overflow
- [ ] 🔴 Repealed article title shows "(Repealed)" suffix in italic
- [ ] 🔴 Omitted article title shows "(Omitted)" suffix in italic

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 3.4 Article Body Text

- [ ] 🔴 Article text renders in Georgia serif font
- [ ] 🔴 Constitutional language reads as intended — no garbled characters
- [ ] 🔴 Special characters (section symbols §, em-dashes —, non-breaking spaces) render correctly
- [ ] 🔴 Unicode Roman numerals render correctly if present

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

## 4. Previous Button Works

### 4.1 Button Appearance

- [ ] 🔴 "Previous" label is visible in bottom navigation bar
- [ ] 🔴 Back arrow icon (`←`) is visible to the left of the label
- [ ] 🔴 Button is in the left third of the navigation bar
- [ ] 🔴 When at the first section/article: button appears dimmed (28% opacity)
- [ ] 🔴 When at the first section/article: button does not respond to taps
- [ ] 🔴 When a previous section/article exists: button appears at full opacity

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 4.2 Button Interaction

Navigate to a section that is not the first in its chapter.

- [ ] 🔴 Tapping Previous loads the previous section/article
- [ ] 🔴 Content updates — title and number badge change to previous item
- [ ] 🔴 Scroll position resets to top of new content
- [ ] 🔴 `HapticFeedback` fires on tap (subtle vibration)
- [ ] 🔴 Press state: button text dims to 42% opacity on finger down
- [ ] 🔴 Press state releases correctly on finger up
- [ ] 🔴 Tapping Previous multiple times navigates backwards through the sequence
- [ ] 🔴 App does not crash at any point during backward navigation

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

## 5. Next Button Works

### 5.1 Button Appearance

- [ ] 🔴 "Next" label is visible in bottom navigation bar
- [ ] 🔴 Forward arrow icon (`→`) is visible to the right of the label
- [ ] 🔴 Button is in the right third of the navigation bar
- [ ] 🔴 When at the last section/article: button appears dimmed (28% opacity)
- [ ] 🔴 When at the last section/article: button does not respond to taps
- [ ] 🔴 When a next section/article exists: button appears at full opacity

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 5.2 Button Interaction

Navigate to a section that is not the last in its chapter.

- [ ] 🔴 Tapping Next loads the next section/article
- [ ] 🔴 Content updates — title and number badge change to next item
- [ ] 🔴 Scroll position resets to top of new content
- [ ] 🔴 `HapticFeedback` fires on tap
- [ ] 🔴 Press state: button text dims on finger down, releases on finger up
- [ ] 🔴 Tapping Next multiple times navigates forward through the sequence
- [ ] 🔴 App does not crash at any point during forward navigation
- [ ] 🔴 Navigation alternating Previous → Next → Previous → Next works correctly

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

## 6. Bookmark Button Works

### 6.1 Initial State (Not Bookmarked)

Open a section that has never been bookmarked.

- [ ] 🔴 Bookmark icon is `bookmark_border_rounded` (outline, not filled)
- [ ] 🔴 Bookmark icon colour is secondary/muted — not accent
- [ ] 🔴 Label below icon reads "Bookmark"
- [ ] 🔴 Label colour is tertiary/muted
- [ ] 🔴 Button is centred in the navigation bar

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 6.2 Bookmark Action (Add)

Tap the Bookmark button on a non-bookmarked section.

- [ ] 🔴 Loading spinner appears briefly during save operation
- [ ] 🔴 Spinner disappears after save completes
- [ ] 🔴 Icon changes to `bookmark_rounded` (filled)
- [ ] 🔴 Icon colour changes to accent colour
- [ ] 🔴 Label changes from "Bookmark" to "Saved"
- [ ] 🔴 Label colour changes to accent colour
- [ ] 🔴 Transition between states is animated — not an instant jump
- [ ] 🔴 `HapticFeedback.mediumImpact()` fires (stronger vibration than navigation)

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 6.3 Bookmark State Persistence

After bookmarking a section, close and reopen the app.

- [ ] 🔴 App reopens correctly to Home screen
- [ ] 🔴 Navigate back to the bookmarked section
- [ ] 🔴 Bookmark icon is filled (bookmarked state) — not reset to empty
- [ ] 🔴 Label reads "Saved"
- [ ] 🔴 Bookmark icon is in correct state from first render — no flash of wrong state

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 6.4 Bookmark Action (Remove)

Tap the Bookmark button on an already-bookmarked section.

- [ ] 🔴 Loading spinner appears briefly during remove operation
- [ ] 🔴 Spinner disappears after remove completes
- [ ] 🔴 Icon changes back to `bookmark_border_rounded` (outline)
- [ ] 🔴 Icon colour returns to secondary/muted
- [ ] 🔴 Label changes back to "Bookmark"
- [ ] 🔴 Label colour returns to tertiary/muted
- [ ] 🔴 Transition is animated

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 6.5 Bookmark in My Notes & Bookmarks

Navigate to My Notes & Bookmarks screen.

- [ ] 🔴 Bookmarks tab shows the section that was just bookmarked
- [ ] 🔴 Bookmark entry shows the section title
- [ ] 🔴 Tapping the bookmark entry opens the Reader on that section
- [ ] 🔴 Removed bookmark does not appear in the list

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

## 7. Case Law List Displays

Navigate to a section that has linked case laws (verify in JSON that `case_law_ids` is non-empty).

### 7.1 Case Laws Section Appearance

- [ ] 🔴 Gradient divider appears below the main content
- [ ] 🔴 Divider fades from transparent at edges to visible in centre — not a hard line
- [ ] 🔴 Gavel icon (`⚖`) appears to the left of the section label
- [ ] 🔴 "Linked Case Laws" label appears next to the gavel icon
- [ ] 🔴 Count badge shows correct number of linked case laws
- [ ] 🔴 Count badge is a small pill shape, not just text
- [ ] 🔴 Section header is smaller and lighter than the main content — supporting role

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 7.2 Case Law Row Appearance

- [ ] 🔴 Each case law entry appears as a separate row
- [ ] 🔴 Case law name is in Georgia italic — distinct from the section label
- [ ] 🔴 Arrow icon (`→`) appears to the left of each case law name
- [ ] 🔴 Trailing chevron (`>`) appears to the right of each case law name
- [ ] 🔴 Row height is comfortable — not too tight, not excessively tall
- [ ] 🔴 Multiple case laws stack vertically without overlapping

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 7.3 Case Laws Section Hidden When Empty

Navigate to a section where `case_law_ids` is empty or absent.

- [ ] 🔴 No case laws section appears
- [ ] 🔴 No gradient divider appears
- [ ] 🔴 No "Linked Case Laws" label appears
- [ ] 🔴 Content ends cleanly after the last content block
- [ ] 🔴 No empty container or extra spacing where case laws section would be

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

## 8. Case Law Modal Opens

Tap any case law row.

### 8.1 Modal Appearance

- [ ] 🔴 Modal opens — a bottom sheet rises from the bottom of the screen
- [ ] 🔴 Modal opening animation is smooth — not instant, not slow
- [ ] 🔴 Modal covers approximately 80–90% of the screen height
- [ ] 🔴 Drag handle (small pill/line) is visible at the top of the modal
- [ ] 🔴 Modal has rounded top corners
- [ ] 🔴 Background behind modal is dimmed and blurred
- [ ] 🔴 Content below is still partially visible at the bottom (modal does not fill 100%)

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 8.2 Modal Header Content

- [ ] 🔴 Case name appears prominently at the top of modal content
- [ ] 🔴 Case name is Georgia font, bold, large enough to identify at a glance
- [ ] 🔴 Citation (e.g. "AIR 1978 SC 597") appears in accent colour
- [ ] 🔴 Court name appears in secondary text colour
- [ ] 🔴 Year appears alongside or below court name
- [ ] 🔴 Horizontal divider separates header from body content
- [ ] 🔴 Header information is not truncated — all fields visible

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 8.3 Modal Body Content

- [ ] 🔴 "FACTS" section label appears with correct styling (small caps / bold label)
- [ ] 🔴 Facts text renders in Georgia, readable font size
- [ ] 🔴 "ISSUES" section label appears
- [ ] 🔴 Issues text renders — as numbered list if multiple issues
- [ ] 🔴 "JUDGMENT" section label appears
- [ ] 🔴 Judgment text renders correctly
- [ ] 🔴 "REASONING" section label appears
- [ ] 🔴 Reasoning text renders correctly
- [ ] 🔴 "SIGNIFICANCE" section label appears
- [ ] 🔴 Significance text renders correctly
- [ ] 🔴 Spacing between sections is consistent and comfortable
- [ ] 🔴 No section label or content is missing

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 8.4 Loading State in Modal

For a case law ID that requires loading:

- [ ] 🔴 Loading indicator appears while case law data is being fetched
- [ ] 🔴 Loading state does not persist indefinitely — resolves to content or error
- [ ] 🔴 Content replaces loading state smoothly

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 8.5 Error State in Modal

For a case law ID that does not exist in the data:

- [ ] 🔴 Error state appears — not a crash
- [ ] 🔴 Error message is readable
- [ ] 🔴 App continues to function after dismissing error modal

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

## 9. Case Law Modal Closes

### 9.1 Close by Drag

- [ ] 🔴 Dragging the modal downward begins to close it
- [ ] 🔴 Modal follows finger movement — it feels connected to the gesture
- [ ] 🔴 Releasing after dragging past the threshold dismisses the modal fully
- [ ] 🔴 Releasing before the threshold snaps the modal back to open position
- [ ] 🔴 Dismiss animation is smooth — modal slides down and out

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 9.2 Close by Tapping Behind Modal

- [ ] 🔴 Tapping the dimmed area behind the modal closes it
- [ ] 🔴 Close animation is the same as drag dismiss
- [ ] 🔴 Reader screen is fully interactive after modal closes

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 9.3 State After Modal Close

- [ ] 🔴 Reader screen is fully visible and interactive after modal closes
- [ ] 🔴 Scroll position in Reader is unchanged from before modal opened
- [ ] 🔴 Bottom navigation bar is visible and functional
- [ ] 🔴 Another case law can be tapped immediately after first modal closes

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

## 10. Smooth Scrolling Verified

### 10.1 Basic Scroll Feel

Scroll through a section with 5+ content blocks.

- [ ] 🔴 Scrolling begins immediately on first touch — no delay
- [ ] 🔴 Content tracks finger movement precisely
- [ ] 🔴 No jitter or stutter during scroll
- [ ] 🔴 Scroll velocity feels natural — not too fast, not too slow
- [ ] 🔴 Momentum (flick) scrolling works — content continues after finger lifts
- [ ] 🔴 Bounce at top and bottom of content — scroll overshoots slightly then snaps back
- [ ] 🔴 Bounce animation is smooth — not a hard stop

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 10.2 Scroll with App Bar Visible

- [ ] 🔴 App bar remains fixed at top during scroll — does not scroll with content
- [ ] 🔴 Content visibly scrolls behind the app bar (visible through glass blur)
- [ ] 🔴 No visual artifacts where content meets app bar

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 10.3 Scroll with Bottom Nav Visible

- [ ] 🔴 Bottom navigation bar remains fixed during scroll
- [ ] 🔴 Content visibly scrolls behind the navigation bar (glass effect)
- [ ] 🔴 Last paragraph of content can be fully scrolled into view — not hidden behind nav bar
- [ ] 🔴 No visual artifacts where content meets bottom navigation bar

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 10.4 Scroll in Case Law Modal

- [ ] 🔴 Modal content scrolls independently of the Reader screen behind it
- [ ] 🔴 Scroll in modal does not cause the modal to close
- [ ] 🔴 Modal scrolls to show all case law content
- [ ] 🔴 Momentum scrolling works within the modal

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

## 11. Dark Mode Verified

Switch device or app to dark mode. Repeat all critical tests in dark mode.

### 11.1 Reader in Dark Mode

- [ ] 🔴 Reader background is very dark — approximately `#0D1117` (dark navy, not pure black)
- [ ] 🔴 Background is not pure black (`#000000`) — there is a slight warm or cool tint
- [ ] 🔴 Body text is near-white — high contrast against dark background
- [ ] 🔴 Georgia font is readable at normal brightness in dark mode
- [ ] 🔴 Side margins are visible — text does not touch screen edges

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 11.2 Number Badge in Dark Mode

- [ ] 🔴 Badge uses lighter accent colour (`accentLight`, approximately `#93C5FD`)
- [ ] 🔴 Badge background is accent at low opacity — visible but not blinding
- [ ] 🔴 Badge text is readable against the badge background

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 11.3 Content Blocks in Dark Mode

- [ ] 🔴 Explanation block left border is accent light colour in dark mode
- [ ] 🔴 Explanation text is readable in dark mode
- [ ] 🔴 Proviso block left border is gold — same in dark and light mode
- [ ] 🔴 Proviso text is readable in dark mode
- [ ] 🔴 All block types have sufficient contrast against dark background

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 11.4 App Bar in Dark Mode

- [ ] 🔴 App bar background is dark translucent — not white or light
- [ ] 🔴 App bar blur is visible — content behind is blurred
- [ ] 🔴 Section label in app bar is `accentLight` colour — readable
- [ ] 🔴 Act/part name in app bar is secondary text — readable but muted
- [ ] 🔴 Back button icon is light coloured (white or near-white)

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 11.5 Bottom Navigation Bar in Dark Mode

- [ ] 🔴 Navigation bar background is dark translucent
- [ ] 🔴 Navigation bar blur is visible
- [ ] 🔴 "Previous" and "Next" text is light coloured and readable
- [ ] 🔴 Bookmark icon is light coloured when not bookmarked
- [ ] 🔴 Bookmark icon is `accentLight` when bookmarked
- [ ] 🔴 "Saved" label is `accentLight` when bookmarked

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 11.6 Case Law Section in Dark Mode

- [ ] 🔴 Gradient divider is visible against dark background
- [ ] 🔴 Gavel icon and section label are readable in secondary/muted light colour
- [ ] 🔴 Case law rows are readable — Georgia italic in secondary text colour
- [ ] 🔴 Arrow and chevron icons are visible

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 11.7 Case Law Modal in Dark Mode

- [ ] 🔴 Modal background is dark — not light grey or white
- [ ] 🔴 Modal blur effect is visible
- [ ] 🔴 Case name is readable in light primary text
- [ ] 🔴 Citation is readable in `accentLight` colour
- [ ] 🔴 All body sections are readable
- [ ] 🔴 Section labels are readable in secondary/muted light colour

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

## 12. Typography Verified

### 12.1 Font Face Verification

- [ ] 🔴 Body text visually appears as a serif font — letters have serifs (small feet and crossbars)
- [ ] 🔴 Body text is distinctly different from the system sans-serif font used in app navigation
- [ ] 🔴 Title text uses the same serif font as body — consistent family
- [ ] 🔴 Number badge text uses the same serif font
- [ ] 🔴 App bar navigation labels (Previous, Next, Bookmark) use system font — not serif

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 12.2 Type Scale Verification

Hold device at normal reading distance and verify visually:

- [ ] 🔴 Section/article title is clearly the largest text on the reading surface
- [ ] 🔴 Body text is clearly smaller than the title
- [ ] 🔴 Number badge text is smaller than body text
- [ ] 🔴 App bar title is appropriately sized — not too large, not too small
- [ ] 🔴 Case law section label ("Linked Case Laws") is smaller than body text
- [ ] 🔴 Case law row text is approximately the same size as body text

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 12.3 Weight Hierarchy Verification

- [ ] 🔴 Section title is visually heavier (bolder) than body text
- [ ] 🔴 Number badge text is visually bold
- [ ] 🔴 Explanation label ("Explanation —") is visually bold
- [ ] 🔴 Proviso label ("Provided that —") is visually bold
- [ ] 🔴 Body text weight is regular — not bold, not thin

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 12.4 Italic Verification

- [ ] 🔴 Explanation block text is visually italic — letters are slanted
- [ ] 🔴 Proviso block text is visually italic
- [ ] 🔴 Case law titles in the list are italic
- [ ] 🔴 Case law body text in modal is non-italic (regular upright)
- [ ] 🔴 No unintended italic rendering in main body text

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 12.5 Line Height Verification

Open a section with a long paragraph (5+ lines).

- [ ] 🔴 Lines of text are not cramped — there is visible space between lines
- [ ] 🔴 Space between lines feels generous but not excessive — reading flow is natural
- [ ] 🔴 Line height is consistent throughout the paragraph — no irregular gaps
- [ ] 🔴 Line height in explanation/proviso blocks matches main body — reading rhythm is unbroken

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

## 13. Spacing Verified

### 13.1 Content Padding

- [ ] 🔴 Content does not touch the left edge of the screen — left margin is present
- [ ] 🔴 Content does not touch the right edge of the screen — right margin is present
- [ ] 🔴 Left and right margins appear equal
- [ ] 🔴 Margin size feels appropriate — not too tight, not excessively wide
- [ ] 🔴 Content does not appear under the app bar at top
- [ ] 🔴 Content has breathing room below the app bar before beginning

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 13.2 Between Badge and Title

- [ ] 🔴 Number badge and title do not touch — visible space between them
- [ ] 🔴 Space is comfortable — neither cramped nor excessively large

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 13.3 Between Title and Body

- [ ] 🔴 Title and first body paragraph do not touch — visible space
- [ ] 🔴 Space is noticeably larger than space between body paragraphs — creates clear hierarchy

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 13.4 Between Content Blocks

- [ ] 🔴 Space between paragraphs is consistent throughout the section
- [ ] 🔴 Space between main paragraph and explanation block is consistent
- [ ] 🔴 Space between explanation block and following main paragraph is consistent
- [ ] 🔴 No content blocks are visually merged — each block has its own space

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 13.5 Bottom of Content

- [ ] 🔴 Last content block has breathing room below it before case laws section or end of content
- [ ] 🔴 When scrolled to the very bottom, content is fully visible above the navigation bar
- [ ] 🔴 No content is permanently hidden behind the navigation bar

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

## 14. Large Content Verified

Navigate to a section with the most content blocks available (longest section in available JSON).

### 14.1 Long Section Rendering

- [ ] 🔴 All content blocks render — no blocks are silently skipped
- [ ] 🔴 Content renders in correct order — no blocks appear out of sequence
- [ ] 🔴 Multiple explanation and proviso blocks all render with correct styling
- [ ] 🔴 Numbered sub-sections render in correct numerical order
- [ ] 🔴 App does not crash when rendering a long section

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 14.2 Scroll Through Full Section

- [ ] 🔴 Can scroll from very top to very bottom without interruption
- [ ] 🔴 Scrolling remains smooth at all points — no jank when rendering complex blocks
- [ ] 🔴 Case laws section at bottom is reachable and fully visible
- [ ] 🔴 All case law rows are visible and tappable at the bottom of a long section

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 14.3 Large Article (Constitution)

Navigate to Part III, Article 19 or Article 21 (typically has the most complex content).

- [ ] 🔴 Full article content renders without truncation
- [ ] 🔴 All explanation and proviso blocks render
- [ ] 🔴 Linked case laws section renders with correct count
- [ ] 🔴 Article can be bookmarked from the navigation bar

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

## 15. Long Content Verified

Test the reading experience for a student doing an extended reading session.

### 15.1 Sustained Reading Session

Open a section and read continuously for 5 minutes, scrolling naturally.

- [ ] 🔴 No auto-scroll or unexpected jumps during reading
- [ ] 🔴 Screen does not dim or lock (standard device behaviour — verify app does not override)
- [ ] 🔴 App bar remains stable — no unexpected reappearance or disappearance during scroll
- [ ] 🔴 Navigation bar remains stable at bottom throughout
- [ ] 🔴 No memory warnings or visual glitches after 5 minutes in Reader

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 15.2 Multiple Sections in Sequence

Tap Next 10 times consecutively to read through 10 sections in a row.

- [ ] 🔴 All 10 sections load without error
- [ ] 🔴 Content is distinct in each section — not the same content repeating
- [ ] 🔴 Number badge updates correctly on every section change
- [ ] 🔴 App bar title updates correctly on every section change
- [ ] 🔴 Bookmark state is correct for each section (bookmarked or not)
- [ ] 🔴 Scroll resets to top on every section change
- [ ] 🔴 App remains responsive throughout — no slowdown over multiple navigation events
- [ ] 🔴 App does not crash after 10 consecutive Next taps

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 15.3 Back and Forward Navigation

After reading 5 sections forward, navigate backward 5 sections using Previous.

- [ ] 🔴 Correct section content appears when navigating backward
- [ ] 🔴 Section order when going back matches the order when going forward
- [ ] 🔴 Bookmark states are correct when revisiting sections
- [ ] 🔴 App does not duplicate content or skip sections
- [ ] 🔴 App remains responsive throughout backward navigation

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

### 15.4 Reader After Background/Foreground

Open Reader, put app in background (press Home button), wait 30 seconds, return to app.

- [ ] 🔴 Reader screen is visible exactly as it was before backgrounding
- [ ] 🔴 Scroll position is preserved
- [ ] 🔴 Content is still visible — no blank or reloading state
- [ ] 🔴 Bottom navigation bar is functional immediately
- [ ] 🔴 Bookmark state is correct

Open Reader, put app in background, wait 5 minutes, return to app.

- [ ] 🔴 Reader screen is visible (or gracefully reloads if OS killed the app)
- [ ] 🔴 App does not crash on return from extended background

**Notes:**
```
_______________________________________________
_______________________________________________
```

---

## Test Summary

| Section | Pass | Fail | Skip | Notes |
|---|---|---|---|---|
| 1. Reader Opens Correctly | | | | |
| 2. Section Content Displays | | | | |
| 3. Article Content Displays | | | | |
| 4. Previous Button Works | | | | |
| 5. Next Button Works | | | | |
| 6. Bookmark Button Works | | | | |
| 7. Case Law List Displays | | | | |
| 8. Case Law Modal Opens | | | | |
| 9. Case Law Modal Closes | | | | |
| 10. Smooth Scrolling Verified | | | | |
| 11. Dark Mode Verified | | | | |
| 12. Typography Verified | | | | |
| 13. Spacing Verified | | | | |
| 14. Large Content Verified | | | | |
| 15. Long Content Verified | | | | |

---

## Failures Requiring Resolution

| # | Section | Test | Description | Priority | Resolved |
|---|---|---|---|---|---|
| 1 | | | | 🔴/🟡 | ☐ |
| 2 | | | | | ☐ |
| 3 | | | | | ☐ |
| 4 | | | | | ☐ |
| 5 | | | | | ☐ |

---

## Sign-Off

All 🔴 items verified passing:

**Tester signature:** ___________________  
**Date:** ___________________  
**Build approved for:** ☐ Debug distribution  ☐ Release distribution

---

*End of checklist.*
