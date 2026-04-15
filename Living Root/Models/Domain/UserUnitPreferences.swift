import Foundation

enum TemperatureUnit: String, CaseIterable, Codable, Identifiable {
    case celsius
    case fahrenheit

    var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .celsius:
            return "Celsius"
        case .fahrenheit:
            return "Fahrenheit"
        }
    }
}

enum ConductivityUnit: String, CaseIterable, Codable, Identifiable {
    case milliSiemens
    case microSiemens

    var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .milliSiemens:
            return "mS/cm"
        case .microSiemens:
            return "µS/cm"
        }
    }
}
