import SwiftUI

struct SettingsView: View {
    @Bindable var viewModel: SettingsViewModel

    var body: some View {
        NavigationStack {
            Form {
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
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
