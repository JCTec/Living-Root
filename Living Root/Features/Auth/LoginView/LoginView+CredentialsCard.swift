import SwiftUI

extension LoginView {
    struct CredentialsCard: View {
        @Binding var username: String
        @Binding var password: String

        let errorMessage: String?
        let isLoading: Bool
        let isSignInDisabled: Bool
        let onSignInTap: () -> Void
        let onUseDevelopmentCredentialsTap: (() -> Void)?

        @Environment(\.colorScheme) private var colorScheme

        var body: some View {
            LRCard {
                VStack(
                    alignment: .leading,
                    spacing: LRSpacing.medium
                ) {
                    Text("Account")
                        .font(.headline)
                        .foregroundStyle(
                            LRPalette.textPrimary(
                                for: colorScheme
                            )
                        )

                    TextField(
                        "Username",
                        text: $username
                    )
                    .accessibilityIdentifier(
                        LoginAccessibilityIdentifiers.usernameTextField
                    )
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding(.horizontal, LRSpacing.medium)
                    .padding(.vertical, LRSpacing.small)
                    .background(
                        RoundedRectangle(
                            cornerRadius: LRRadius.medium,
                            style: .continuous
                        )
                        .fill(
                            LRPalette.background(
                                for: colorScheme
                            )
                        )
                    )

                    SecureField(
                        "Password",
                        text: $password
                    )
                    .accessibilityIdentifier(
                        LoginAccessibilityIdentifiers.passwordTextField
                    )
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding(.horizontal, LRSpacing.medium)
                    .padding(.vertical, LRSpacing.small)
                    .background(
                        RoundedRectangle(
                            cornerRadius: LRRadius.medium,
                            style: .continuous
                        )
                        .fill(
                            LRPalette.background(
                                for: colorScheme
                            )
                        )
                    )

                    if let errorMessage {
                        Text(errorMessage)
                            .accessibilityIdentifier(
                                LoginAccessibilityIdentifiers.errorMessage
                            )
                            .font(.footnote)
                            .foregroundStyle(
                                LRPalette.critical
                            )
                    }

                    if let onUseDevelopmentCredentialsTap {
                        Button("Use development credentials") {
                            onUseDevelopmentCredentialsTap()
                        }
                        .accessibilityIdentifier(
                            LoginAccessibilityIdentifiers.useDevelopmentCredentialsButton
                        )
                        .font(.footnote.weight(.semibold))
                    }

                    Button(
                        action: onSignInTap
                    ) {
                        HStack(
                            spacing: LRSpacing.small
                        ) {
                            if isLoading {
                                ProgressView()
                                    .tint(.white)
                            }

                            Text(isLoading ? "Signing in..." : "Sign In")
                                .font(.body.weight(.semibold))
                        }
                        .frame(
                            maxWidth: .infinity
                        )
                        .padding(.vertical, LRSpacing.small)
                    }
                    .buttonStyle(.borderedProminent)
                    .accessibilityIdentifier(
                        LoginAccessibilityIdentifiers.signInButton
                    )
                    .disabled(
                        isSignInDisabled
                    )
                }
            }
        }
    }
}
