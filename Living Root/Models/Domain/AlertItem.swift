import Foundation

struct AlertItem: Codable, Hashable, Identifiable {
    let id: UUID
    let title: String
    let message: String
    let timestamp: Date
    var isUnread: Bool
    let relatedState: SystemHealthState

    init(
        id: UUID = UUID(),
        title: String,
        message: String,
        timestamp: Date,
        isUnread: Bool,
        relatedState: SystemHealthState
    ) {
        self.id = id
        self.title = title
        self.message = message
        self.timestamp = timestamp
        self.isUnread = isUnread
        self.relatedState = relatedState
    }
}
