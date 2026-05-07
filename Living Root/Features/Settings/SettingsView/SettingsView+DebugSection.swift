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
                .accessibilityIdentifier(
                    SettingsAccessibilityIdentifiers.demoModeToggle
                )

                Toggle(
                    "Simulate offline",
                    isOn: viewModel.forceOfflineBinding()
                )
                .accessibilityIdentifier(
                    SettingsAccessibilityIdentifiers.forceOfflineToggle
                )

                NavigationLink("Design System Showcase") {
                    DesignSystemShowcaseView()
                }
                .accessibilityIdentifier(
                    SettingsAccessibilityIdentifiers.designSystemShowcaseLink
                )
            }
        }
    }
}
#endif
