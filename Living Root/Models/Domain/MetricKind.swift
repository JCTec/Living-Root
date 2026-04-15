import Foundation

enum MetricKind: String, CaseIterable, Codable, Hashable, Identifiable {
    case ph
    case ec
    case waterTemperature
    case waterLevel

    var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .ph:
            return "pH"
        case .ec:
            return "EC"
        case .waterTemperature:
            return "Water Temperature"
        case .waterLevel:
            return "Water Level"
        }
    }

    var sfSymbol: String {
        switch self {
        case .ph:
            return "drop"
        case .ec:
            return "bolt.horizontal"
        case .waterTemperature:
            return "thermometer.medium"
        case .waterLevel:
            return "water.waves"
        }
    }
}
