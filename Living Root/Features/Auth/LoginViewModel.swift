import Foundation
import Observation

@MainActor
@Observable
final class LoginViewModel {
    private let authStore: AuthStore

    var username = ""
    var password = ""
    var errorMessage: String?
    var isLoading = false

    init(dependencies: AppDependencies) {
        authStore = dependencies.authStore
    }

    var isSignInDisabled: Bool {
        isLoading
            || username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || password.isEmpty
    }

    func signIn() async {
        guard !isSignInDisabled else {
            return
        }

        isLoading = true
        defer {
            isLoading = false
        }

        do {
            try await authStore.signIn(
                username: username,
                password: password
            )
            errorMessage = nil
            password = ""
        } catch {
            errorMessage = error.localizedDescription
        }
    }

#if DEBUG
    func useDevelopmentCredentials() {
        username = "admin"
        password = "living-root-admin"
    }
#endif
}
