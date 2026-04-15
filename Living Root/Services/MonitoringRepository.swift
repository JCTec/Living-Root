import Foundation
import Observation

@MainActor
@Observable
final class MonitoringRepository {
    private let apiService: MonitoringAPIService
    private let cacheService: SnapshotCacheService

    var currentSnapshot: MonitoringSnapshot?
    var isLoading = false
    var isShowingCachedSnapshot = false
    var statusMessage: String?

    init(
        apiService: MonitoringAPIService,
        cacheService: SnapshotCacheService
    ) {
        self.apiService = apiService
        self.cacheService = cacheService
    }

    var unreadAlertCount: Int {
        currentSnapshot?.alerts.filter(\.isUnread).count ?? 0
    }

    func loadSnapshot(
        forceRefresh: Bool,
        demoModeEnabled: Bool,
        forceOffline: Bool
    ) async {
        guard !isLoading else {
            return
        }

        if !forceRefresh, currentSnapshot != nil {
            return
        }

        isLoading = true
        defer {
            isLoading = false
        }

        do {
            let remoteSnapshot = try await apiService.fetchSnapshot(
                demoModeEnabled: demoModeEnabled,
                forceOffline: forceOffline
            )
            currentSnapshot = remoteSnapshot
            isShowingCachedSnapshot = false
            statusMessage = nil

            try? cacheService.save(
                snapshot: remoteSnapshot
            )
            return
        } catch {
            statusMessage = "Showing cached data while connection is unavailable."
        }

        do {
            if let cachedSnapshot = try cacheService.loadSnapshot() {
                currentSnapshot = cachedSnapshot
                isShowingCachedSnapshot = true
                return
            }
        } catch {
            statusMessage = "Unable to decode cached data."
        }

        isShowingCachedSnapshot = false
        statusMessage = "Data is currently unavailable."
    }

    func markAllAlertsAsRead() {
        guard var snapshot = currentSnapshot else {
            return
        }

        snapshot.alerts = snapshot.alerts.map { alert in
            var mutableAlert = alert
            mutableAlert.isUnread = false
            return mutableAlert
        }

        currentSnapshot = snapshot
        try? cacheService.save(
            snapshot: snapshot
        )
    }

    func markAlertAsRead(
        id: UUID
    ) {
        guard var snapshot = currentSnapshot else {
            return
        }

        snapshot.alerts = snapshot.alerts.map { alert in
            guard alert.id == id else {
                return alert
            }

            var mutableAlert = alert
            mutableAlert.isUnread = false
            return mutableAlert
        }

        currentSnapshot = snapshot
        try? cacheService.save(
            snapshot: snapshot
        )
    }
}
