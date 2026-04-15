import Foundation

struct MetricReading: Codable, Hashable, Identifiable {
    let kind: MetricKind
    let value: Double
    let historyByRange: [MetricRange: [MetricSample]]

    var id: MetricKind {
        kind
    }

    func samples(
        for range: MetricRange
    ) -> [MetricSample] {
        historyByRange[range] ?? []
    }
}
