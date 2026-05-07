import Observation
import SwiftUI

@MainActor
@Observable
final class SettingsViewModel {
    private let dependencies: AppDependencies

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }

    var refreshBehaviorText: String {
        "Load on start and pull to refresh."
    }

    var signedInName: String {
        dependencies.authStore.currentUser?.name ?? "Unknown User"
    }

    var signedInUsername: String {
        dependencies.authStore.currentUser?.username ?? "unknown"
    }

    func temperatureUnitBinding() -> Binding<TemperatureUnit> {
        Binding(
            get: {
                self.dependencies.settingsStore.temperatureUnit
            },
            set: {
                self.dependencies.settingsStore.temperatureUnit = $0
            }
        )
    }

    func conductivityUnitBinding() -> Binding<ConductivityUnit> {
        Binding(
            get: {
                self.dependencies.settingsStore.conductivityUnit
            },
            set: {
                self.dependencies.settingsStore.conductivityUnit = $0
            }
        )
    }

    func refreshNow() async {
        await dependencies.refreshSnapshot(
            forceRefresh: true
        )
    }

    func signOut() {
        dependencies.authStore.signOut()
    }

#if DEBUG
    func demoModeBinding() -> Binding<Bool> {
        Binding(
            get: {
                self.dependencies.debugStore.isDemoModeEnabled
            },
            set: {
                self.dependencies.debugStore.isDemoModeEnabled = $0
            }
        )
    }

    func forceOfflineBinding() -> Binding<Bool> {
        Binding(
            get: {
                self.dependencies.debugStore.isForceOfflineEnabled
            },
            set: {
                self.dependencies.debugStore.isForceOfflineEnabled = $0
            }
        )
    }
#endif
}
