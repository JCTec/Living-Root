import SwiftUI

extension DashboardView {
    struct MetricsHeader: View {
        let onChangeOrderTap: () -> Void

        @Environment(\.colorScheme) private var colorScheme

        var body: some View {
            HStack {
                Text("Metrics")
                    .font(.headline)
                    .foregroundStyle(
                        LRPalette.textPrimary(
                            for: colorScheme
                        )
                    )

                Spacer()

                Button("Change Order") {
                    onChangeOrderTap()
                }
                .accessibilityIdentifier(
                    DashboardAccessibilityIdentifiers.changeOrderButton
                )
                .font(.subheadline.weight(.semibold))
            }
        }
    }
}
