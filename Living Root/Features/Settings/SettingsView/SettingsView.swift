import SwiftUI

struct SettingsView: View {
    @Bindable var viewModel: SettingsViewModel

    var body: some View {
        NavigationStack {
            Form {
                AccountSection(
                    viewModel: viewModel
                )

                UnitsSection(
                    viewModel: viewModel
                )

                RefreshSection(
                    viewModel: viewModel
                )

#if DEBUG
                DebugSection(
                    viewModel: viewModel
                )
#endif
            }
            .accessibilityIdentifier(
                SettingsAccessibilityIdentifiers.rootView
            )
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
