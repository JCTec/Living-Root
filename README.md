# Living Root

Living Root is a SwiftUI iOS app for monitoring a hydroponic system with clear health states, trend visualizations, insights, and alerts.

## Highlights

- Dashboard with 4 core metrics: pH, EC, water temperature, and water level.
- System status modeled as `stable`, `warning`, or `critical`.
- Expandable metric cards with trend charts (24h, 7d, 30d).
- Change-order flow for metrics, always in active reorder mode.
- Insights feed and Alerts feed with unread badge support.
- Offline fallback to cached snapshots with an inline status banner.
- Settings for unit preferences and debug-only controls.

## Tech Stack

- SwiftUI for UI and navigation.
- Observation (`@Observable`, `@Bindable`) for state flow.
- SwiftData for local snapshot persistence.
- Repository + services split for data orchestration.
- SwiftLint enforced in Xcode build phase.

## Architecture Overview

- `App/`
  - App composition and dependency container (`AppDependencies`).
- `Features/`
  - Dashboard, Insights, Alerts, Settings views + view models.
- `Models/Domain/`
  - Domain entities (`MonitoringSnapshot`, `MetricReading`, `AlertItem`, etc).
- `Models/Persistence/`
  - SwiftData persistence model (`CachedSnapshotRecord`).
- `Services/`
  - Repository and stores (`MonitoringRepository`, `SettingsStore`, `DebugStore`, etc).
- `DesignSystem/`
  - Shared tokens (`LRPalette`, `LRSpacing`, `LRRadius`) and UI components.

## Requirements

- macOS with Xcode 26.x.
- iOS Simulator runtime compatible with deployment target `26.0`.
- SwiftLint installed (recommended via Homebrew):

```bash
brew install swiftlint
```

## Run Locally

```bash
open "Living Root.xcodeproj"
```

Or build from terminal:

```bash
xcodebuild \
  -project "Living Root.xcodeproj" \
  -scheme "Living Root" \
  -destination "generic/platform=iOS Simulator" \
  build
```

## Lint

```bash
swiftlint lint --config ".swiftlint.yml" "Living Root" --strict --no-cache
```

SwiftLint is also run in a build phase. The script already prepends Homebrew paths:

- `/opt/homebrew/bin`
- `/usr/local/bin`

## Debug-Only Features

`Settings -> Debug` is available only in `DEBUG` builds:

- Enable demo mode (randomized values for UI testing).
- Simulate offline mode.
- Open Design System Showcase screen.

## Data Flow

1. App bootstraps dependencies and loads snapshot data.
2. `MonitoringRepository` requests a remote snapshot from `MockMonitoringAPIService`.
3. On success, snapshot is cached in SwiftData.
4. On failure, repository falls back to cached snapshot and shows status messaging.

## Notes

- Signing configuration is intentionally left to local environment/project settings.
- `main` is the default branch reference for this repository.
