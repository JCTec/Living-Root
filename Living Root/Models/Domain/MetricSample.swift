import Foundation

struct MetricSample: Codable, Hashable, Identifiable {
    let id: UUID
    let timestamp: Date
    let value: Double

    init(
        id: UUID = UUID(),
        timestamp: Date,
        value: Double
    ) {
        self.id = id
        self.timestamp = timestamp
        self.value = value
    }
}
