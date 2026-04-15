import SwiftUI

extension InsightsView {
    struct InsightCard: View {
        let insight: InsightItem

        @Environment(\.colorScheme) private var colorScheme

        var body: some View {
            LRCard {
                VStack(
                    alignment: .leading,
                    spacing: LRSpacing.small
                ) {
                    Text(insight.title)
                        .font(.headline)
                        .foregroundStyle(
                            LRPalette.textPrimary(
                                for: colorScheme
                            )
                        )

                    Text(insight.message)
                        .font(.body)
                        .foregroundStyle(
                            LRPalette.textSecondary(
                                for: colorScheme
                            )
                        )

                    Text(
                        insight.timestamp.formatted(
                            date: .abbreviated,
                            time: .shortened
                        )
                    )
                    .font(.caption)
                    .foregroundStyle(
                        LRPalette.textSecondary(
                            for: colorScheme
                        )
                    )
                }
            }
        }
    }
}
