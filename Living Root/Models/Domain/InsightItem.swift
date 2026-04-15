import Foundation

struct InsightItem: Codable, Hashable, Identifiable {
    let id: UUID
    let title: String
    let message: String
    let timestamp: Date
    let relatedState: SystemHealthState

    init(
        id: UUID = UUID(),
        title: String,
        message: String,
        timestamp: Date,
        relatedState: SystemHealthState
    ) {
        self.id = id
        self.title = title
        self.message = message
        self.timestamp = timestamp
        self.relatedState = relatedState
    }
}
