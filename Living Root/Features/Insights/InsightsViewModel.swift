import Foundation
import Observation

@MainActor
@Observable
final class InsightsViewModel {
    private let dependencies: AppDependencies
    private var hasLoaded = false

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }

    var insights: [InsightItem] {
        (dependencies.monitoringRepository.currentSnapshot?.insights ?? [])
            .sorted(
                by: { $0.timestamp > $1.timestamp }
            )
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
}
