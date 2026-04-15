import SwiftUI

struct SettingsView: View {
    @Bindable var viewModel: SettingsViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section("Units") {
                    Picker(
                        "Temperature",
                        selection: viewModel.temperatureUnitBinding()
                    ) {
                        ForEach(
                            TemperatureUnit.allCases
                        ) { unit in
                            Text(unit.title)
                                .tag(unit)
                        }
                    }

                    Picker(
                        "Conductivity",
                        selection: viewModel.conductivityUnitBinding()
                    ) {
                        ForEach(
                            ConductivityUnit.allCases
                        ) { unit in
                            Text(unit.title)
                                .tag(unit)
                        }
                    }
                }

                Section("Refresh") {
                    Text(viewModel.refreshBehaviorText)
                    Button("Refresh now") {
                        Task {
                            await viewModel.refreshNow()
                        }
                    }
                }

#if DEBUG
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
#endif
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
