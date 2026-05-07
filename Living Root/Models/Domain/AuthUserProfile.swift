import Foundation

struct AuthUserProfile: Codable, Hashable, Identifiable {
    let id: String
    let name: String
    let username: String
    let email: String
    let role: String
    let isActive: Bool
}
