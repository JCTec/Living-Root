import Foundation
import SwiftData

@Model
final class CachedSnapshotRecord {
    @Attribute(.unique) var id: String
    var payload: Data
    var savedAt: Date

    init(
        id: String = "primary",
        payload: Data,
        savedAt: Date
    ) {
        self.id = id
        self.payload = payload
        self.savedAt = savedAt
    }
}
