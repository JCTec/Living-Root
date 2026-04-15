#if DEBUG
import SwiftUI

extension SettingsView {
    struct DebugSection: View {
        let viewModel: SettingsViewModel

        var body: some View {
            Section("Debug") {
                Toggle(
                    "Enable demo mode",
                    isOn: viewModel.demoModeBinding()
                )

                Toggle(
                    "Simulate offline",
                    isOn: viewModel.forceOfflineBinding()
                )

                NavigationLink("Design System Showcase") {
                    DesignSystemShowcaseView()
                }
            }
        }
    }
}
#endif
