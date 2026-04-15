import Foundation
import Observation
import SwiftData

@MainActor
@Observable
final class AppDependencies {
    let modelContainer: ModelContainer
    let settingsStore: SettingsStore
    let monitoringRepository: MonitoringRepository

#if DEBUG
    let debugStore: DebugStore
#endif

    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        settingsStore = SettingsStore()
#if DEBUG
        debugStore = DebugStore()
#endif

        let snapshotCacheService = SnapshotCacheService(
            modelContext: modelContainer.mainContext
        )
        let mockMonitoringAPIService = MockMonitoringAPIService()

        monitoringRepository = MonitoringRepository(
            apiService: mockMonitoringAPIService,
            cacheService: snapshotCacheService
        )
    }

    static func makeLive() -> AppDependencies {
        let schema = Schema(
            [
                CachedSnapshotRecord.self
            ]
        )
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            let modelContainer = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
            return AppDependencies(
                modelContainer: modelContainer
            )
        } catch {
            fatalError(
                "Could not create ModelContainer: \(error)"
            )
        }
    }

    func refreshSnapshot(
        forceRefresh: Bool
    ) async {
#if DEBUG
        await monitoringRepository.loadSnapshot(
            forceRefresh: forceRefresh,
            demoModeEnabled: debugStore.isDemoModeEnabled,
            forceOffline: debugStore.isForceOfflineEnabled
        )
#else
        await monitoringRepository.loadSnapshot(
            forceRefresh: forceRefresh,
            demoModeEnabled: false,
            forceOffline: false
        )
#endif
    }
}
