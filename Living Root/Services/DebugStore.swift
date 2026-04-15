#if DEBUG
import Foundation
import Observation

@MainActor
@Observable
final class DebugStore {
    private enum Keys {
        static let demoMode = "debug.demoMode"
        static let forceOffline = "debug.forceOffline"
    }

    private let userDefaults: UserDefaults

    var isDemoModeEnabled: Bool {
        didSet {
            userDefaults.set(
                isDemoModeEnabled,
                forKey: Keys.demoMode
            )
        }
    }

    var isForceOfflineEnabled: Bool {
        didSet {
            userDefaults.set(
                isForceOfflineEnabled,
                forKey: Keys.forceOffline
            )
        }
    }

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        isDemoModeEnabled = userDefaults.bool(
            forKey: Keys.demoMode
        )
        isForceOfflineEnabled = userDefaults.bool(
            forKey: Keys.forceOffline
        )
    }
}
#endif
