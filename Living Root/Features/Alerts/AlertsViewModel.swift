import Foundation
import Observation

@MainActor
@Observable
final class AlertsViewModel {
    private let dependencies: AppDependencies
    private var hasLoaded = false

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }

    var alerts: [AlertItem] {
        (dependencies.monitoringRepository.currentSnapshot?.alerts ?? [])
            .sorted(
                by: { $0.timestamp > $1.timestamp }
            )
    }

    var unreadCount: Int {
        alerts.filter(\.isUnread).count
    }

    var cacheMessage: String? {
        guard dependencies.monitoringRepository.isShowingCachedSnapshot else {
            return nil
        }
        return dependencies.monitoringRepository.statusMessage
    }

    func loadIfNeeded() async {
        guard !hasLoaded else {
            return
        }

        hasLoaded = true
        await dependencies.refreshSnapshot(
            forceRefresh: false
        )
    }

    func refresh() async {
        await dependencies.refreshSnapshot(
            forceRefresh: true
        )
    }

    func markAllAsRead() {
        dependencies.monitoringRepository.markAllAlertsAsRead()
    }

    func markAsRead(
        alertID: UUID
    ) {
        dependencies.monitoringRepository.markAlertAsRead(
            id: alertID
        )
    }
}
