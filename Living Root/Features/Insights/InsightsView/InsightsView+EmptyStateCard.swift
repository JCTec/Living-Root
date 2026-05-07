import SwiftUI

extension InsightsView {
    struct EmptyStateCard: View {
        @Environment(\.colorScheme) private var colorScheme

        var body: some View {
            LRCard {
                Text("No insights available yet.")
                    .font(.body)
                    .foregroundStyle(
                        LRPalette.textSecondary(
                            for: colorScheme
                        )
                    )
            }
            .accessibilityIdentifier(
                InsightsAccessibilityIdentifiers.emptyStateCard
            )
        }
    }
}
