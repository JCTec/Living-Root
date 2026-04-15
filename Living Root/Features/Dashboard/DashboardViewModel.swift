import Foundation
import Observation

@MainActor
@Observable
final class DashboardViewModel {
    private let dependencies: AppDependencies
    private var hasLoaded = false

    var selectedRange: MetricRange = .day24
    var expandedMetricKinds: Set<MetricKind> = Set(MetricKind.allCases)
    var isMetricOrderSheetPresented = false

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }

    var systemState: SystemHealthState {
        dependencies.monitoringRepository.currentSnapshot?.systemState ?? .stable
    }

    var orderedMetrics: [MetricReading] {
        guard let snapshot = dependencies.monitoringRepository.currentSnapshot else {
            return []
        }

        let metricsByKind = Dictionary(
            uniqueKeysWithValues: snapshot.metrics.map {
                ($0.kind, $0)
            }
        )

        return dependencies.settingsStore.metricOrder.compactMap {
            metricsByKind[$0]
        }
    }

    var cacheMessage: String? {
        guard dependencies.monitoringRepository.isShowingCachedSnapshot else {
            return nil
        }
        return dependencies.monitoringRepository.statusMessage
    }

    var lastUpdatedText: String {
        guard let date = dependencies.monitoringRepository.currentSnapshot?.generatedAt else {
            return "No data yet"
        }

        return date.formatted(
            date: .abbreviated,
            time: .shortened
        )
    }

    var metricOrder: [MetricKind] {
        dependencies.settingsStore.metricOrder
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

    func stateTone() -> LRStatusTone {
        switch systemState {
        case .stable:
            return .positive
        case .warning:
            return .caution
        case .critical:
            return .critical
        }
    }

    func displayValue(
        for metricReading: MetricReading
    ) -> String {
        dependencies.settingsStore.displayValue(
            for: metricReading.kind,
            rawValue: metricReading.value
        )
    }

    func displayUnit(
        for metricKind: MetricKind
    ) -> String {
        dependencies.settingsStore.displayUnit(
            for: metricKind
        )
    }

    func chartSamples(
        for metricReading: MetricReading
    ) -> [MetricSample] {
        metricReading.samples(
            for: selectedRange
        ).map { sample in
            let convertedValue = dependencies.settingsStore.convertedValue(
                for: metricReading.kind,
                rawValue: sample.value
            )

            return MetricSample(
                id: sample.id,
                timestamp: sample.timestamp,
                value: convertedValue
            )
        }
    }

    func isExpanded(
        for metricKind: MetricKind
    ) -> Bool {
        expandedMetricKinds.contains(metricKind)
    }

    func toggleExpansion(
        for metricKind: MetricKind
    ) {
        if expandedMetricKinds.contains(metricKind) {
            expandedMetricKinds.remove(metricKind)
        } else {
            expandedMetricKinds.insert(metricKind)
        }
    }

    func moveMetric(
        fromOffsets: IndexSet,
        toOffset: Int
    ) {
        dependencies.settingsStore.moveMetric(
            fromOffsets: fromOffsets,
            toOffset: toOffset
        )
    }
}
