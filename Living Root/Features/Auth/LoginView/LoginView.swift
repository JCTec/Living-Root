import SwiftUI

struct LoginView: View {
    @Bindable var viewModel: LoginViewModel

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(
                    spacing: LRSpacing.xLarge
                ) {
                    Header()

                    CredentialsCard(
                        username: $viewModel.username,
                        password: $viewModel.password,
                        errorMessage: viewModel.errorMessage,
                        isLoading: viewModel.isLoading,
                        isSignInDisabled: viewModel.isSignInDisabled,
                        onSignInTap: {
                            Task {
                                await viewModel.signIn()
                            }
                        },
                        onUseDevelopmentCredentialsTap: useDevelopmentCredentialsAction
                    )
                }
                .padding(.horizontal, LRSpacing.large)
                .padding(.vertical, LRSpacing.xLarge)
            }
            .accessibilityIdentifier(
                LoginAccessibilityIdentifiers.rootView
            )
            .background(
                LRPalette.background(
                    for: colorScheme
                )
                .ignoresSafeArea()
            )
            .navigationTitle("Sign In")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var useDevelopmentCredentialsAction: (() -> Void)? {
#if DEBUG
        {
            viewModel.useDevelopmentCredentials()
        }
#else
        nil
#endif
    }
}
