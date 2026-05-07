import SwiftUI

extension SettingsView {
    struct AccountSection: View {
        let viewModel: SettingsViewModel

        @Environment(\.colorScheme) private var colorScheme

        var body: some View {
            Section("Account") {
                VStack(
                    alignment: .leading,
                    spacing: LRSpacing.xSmall
                ) {
                    Text(viewModel.signedInName)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(
                            LRPalette.textPrimary(
                                for: colorScheme
                            )
                        )

                    Text("@\(viewModel.signedInUsername)")
                        .font(.footnote)
                        .foregroundStyle(
                            LRPalette.textSecondary(
                                for: colorScheme
                            )
                        )
                }

                Button(
                    "Sign Out",
                    role: .destructive
                ) {
                    viewModel.signOut()
                }
                .accessibilityIdentifier(
                    SettingsAccessibilityIdentifiers.signOutButton
                )
            }
        }
    }
}
