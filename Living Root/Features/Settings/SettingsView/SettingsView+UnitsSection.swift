import SwiftUI

extension SettingsView {
    struct UnitsSection: View {
        let viewModel: SettingsViewModel

        var body: some View {
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
                .accessibilityIdentifier(
                    SettingsAccessibilityIdentifiers.temperaturePicker
                )

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
                .accessibilityIdentifier(
                    SettingsAccessibilityIdentifiers.conductivityPicker
                )
            }
        }
    }
}
