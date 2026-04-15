import Foundation

enum SystemHealthState: String, CaseIterable, Codable, Hashable {
    case stable
    case warning
    case critical

    var title: String {
        switch self {
        case .stable:
            return "Stable"
        case .warning:
            return "Warning"
        case .critical:
            return "Critical"
        }
    }
}
