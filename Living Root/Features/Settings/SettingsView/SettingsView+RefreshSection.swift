import SwiftUI

extension SettingsView {
    struct RefreshSection: View {
        let viewModel: SettingsViewModel

        var body: some View {
            Section("Refresh") {
                Text(viewModel.refreshBehaviorText)
                Button("Refresh now") {
                    Task {
                        await viewModel.refreshNow()
                    }
                }
                .accessibilityIdentifier(
                    SettingsAccessibilityIdentifiers.refreshNowButton
                )
            }
        }
    }
}
