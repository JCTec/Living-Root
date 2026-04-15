import SwiftUI

extension DashboardMetricCardView {
    struct Header: View {
        let metricReading: MetricReading
        let isExpanded: Bool
        let valueText: String
        let unitText: String
        let toggleExpansion: () -> Void

        @Environment(\.colorScheme) private var colorScheme

        var body: some View {
            Button(
                action: toggleExpansion
            ) {
                HStack(
                    spacing: LRSpacing.medium
                ) {
                    Image(systemName: metricReading.kind.sfSymbol)
                        .font(.headline)
                        .frame(width: 20)
                        .foregroundStyle(
                            LRPalette.accent
                        )

                    VStack(
                        alignment: .leading,
                        spacing: LRSpacing.xSmall
                    ) {
                        Text(metricReading.kind.title)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(
                                LRPalette.textSecondary(
                                    for: colorScheme
                                )
                            )

                        HStack(
                            alignment: .firstTextBaseline,
                            spacing: LRSpacing.xSmall
                        ) {
                            Text(valueText)
                                .font(.title3.weight(.semibold))
                                .foregroundStyle(
                                    LRPalette.textPrimary(
                                        for: colorScheme
                                    )
                                )

                            if !unitText.isEmpty {
                                Text(unitText)
                                    .font(.footnote)
                                    .foregroundStyle(
                                        LRPalette.textSecondary(
                                            for: colorScheme
                                        )
                                    )
                            }
                        }
                    }

                    Spacer()

                    Image(
                        systemName: isExpanded ? "chevron.up" : "chevron.down"
                    )
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(
                        LRPalette.textSecondary(
                            for: colorScheme
                        )
                    )
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }
}
