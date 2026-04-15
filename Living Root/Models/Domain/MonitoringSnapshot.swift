import Foundation

struct MonitoringSnapshot: Codable, Hashable {
    let generatedAt: Date
    let systemState: SystemHealthState
    var metrics: [MetricReading]
    let insights: [InsightItem]
    var alerts: [AlertItem]
}

extension MonitoringSnapshot {
    func metric(
        for kind: MetricKind
    ) -> MetricReading? {
        metrics.first(
            where: { $0.kind == kind }
        )
    }
}
