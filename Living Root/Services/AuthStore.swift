import Foundation
import Observation

enum AuthStoreError: LocalizedError {
    case invalidCredentials
    case inactiveUser

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid username or password."
        case .inactiveUser:
            return "This account is not active."
        }
    }
}

@MainActor
@Observable
final class AuthStore {
    private enum Keys {
        static let savedUser = "auth.savedUser"
    }

    private let userDefaults: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private let developmentUsername = "admin"
    private let developmentPassword = "living-root-admin"

    var currentUser: AuthUserProfile?

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        currentUser = loadStoredUser()
    }

    var isSignedIn: Bool {
        currentUser != nil
    }

    func signIn(
        username: String,
        password: String
    ) async throws {
        try await Task.sleep(
            for: .milliseconds(280)
        )

        let normalizedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)

        guard normalizedUsername == developmentUsername, password == developmentPassword else {
            throw AuthStoreError.invalidCredentials
        }

        let user = AuthUserProfile(
            id: "local-admin-id",
            name: "Living Root Admin",
            username: developmentUsername,
            email: "admin@livingroot.local",
            role: "ADMIN",
            isActive: true
        )

        guard user.isActive else {
            throw AuthStoreError.inactiveUser
        }

        currentUser = user
        saveCurrentUser()
    }

    func signOut() {
        currentUser = nil
        userDefaults.removeObject(
            forKey: Keys.savedUser
        )
    }

    private func loadStoredUser() -> AuthUserProfile? {
        guard let data = userDefaults.data(
            forKey: Keys.savedUser
        ) else {
            return nil
        }

        return try? decoder.decode(
            AuthUserProfile.self,
            from: data
        )
    }

    private func saveCurrentUser() {
        guard let currentUser else {
            return
        }

        guard let data = try? encoder.encode(
            currentUser
        ) else {
            return
        }

        userDefaults.set(
            data,
            forKey: Keys.savedUser
        )
    }
}
