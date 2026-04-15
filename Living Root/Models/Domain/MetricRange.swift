import Foundation

enum MetricRange: String, CaseIterable, Codable, Hashable, Identifiable {
    case day24
    case day7
    case day30

    var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .day24:
            return "24h"
        case .day7:
            return "7d"
        case .day30:
            return "30d"
        }
    }
}
