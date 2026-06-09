# Bad Birdie — Claude Instructions

## Stack
- Flutter 3.38.5 / Dart
- Material 3 design system
- Flutter i18n (ARB files in lib/l10n/)
- Android-first, iOS planned

## Project structure
- lib/l10n/ — localization ARB files (en, de)
- lib/ — main app code

## Rules
- Output targeted diffs only, never full file rewrites
- Use Material 3 widgets and theming — no custom paint unless unavoidable
- All user-facing strings must go through l10n (never hardcode text)
- State management: keep it simple, no heavy packages unless justified
- Dart: follow effective dart style, prefer const constructors
- When adding features, check if l10n keys exist before creating new ones
- Run `flutter gen-l10n` after any ARB file changes

## Current features (v1.0.0)
- Multi-language (EN, DE)
- Material 3 UI

## In progress
- Footwork training (interactive drills + timer)
- Tactical board (digital strategy tool)
- Learning hub (YouTube/tutorial links)
- Progress tracking (stats)

## Commands
```bash
flutter pub get
flutter gen-l10n
flutter run
flutter build appbundle --release
flutter build apk --release
```
