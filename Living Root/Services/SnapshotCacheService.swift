import Foundation
import SwiftData

@MainActor
final class SnapshotCacheService {
    private let modelContext: ModelContext
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601
    }

    func save(
        snapshot: MonitoringSnapshot
    ) throws {
        let payload = try encoder.encode(
            snapshot
        )
        let descriptor = FetchDescriptor<CachedSnapshotRecord>(
            predicate: #Predicate {
                $0.id == "primary"
            }
        )

        if let record = try modelContext.fetch(
            descriptor
        ).first {
            record.payload = payload
            record.savedAt = Date.now
        } else {
            let record = CachedSnapshotRecord(
                payload: payload,
                savedAt: Date.now
            )
            modelContext.insert(record)
        }

        try modelContext.save()
    }

    func loadSnapshot() throws -> MonitoringSnapshot? {
        let descriptor = FetchDescriptor<CachedSnapshotRecord>(
            predicate: #Predicate {
                $0.id == "primary"
            }
        )

        guard let record = try modelContext.fetch(
            descriptor
        ).first else {
            return nil
        }

        return try decoder.decode(
            MonitoringSnapshot.self,
            from: record.payload
        )
    }
}
