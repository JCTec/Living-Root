import Charts
import SwiftUI

struct DashboardMetricCardView: View {
    let metricReading: MetricReading
    @Binding var selectedRange: MetricRange
    let isExpanded: Bool
    let valueText: String
    let unitText: String
    let chartSamples: [MetricSample]
    let toggleExpansion: () -> Void

    var body: some View {
        LRCard {
            VStack(
                spacing: LRSpacing.medium
            ) {
                Header(
                    metricReading: metricReading,
                    isExpanded: isExpanded,
                    valueText: valueText,
                    unitText: unitText,
                    toggleExpansion: toggleExpansion
                )

                if isExpanded {
                    ChartView(
                        metricKind: metricReading.kind,
                        selectedRange: $selectedRange,
                        chartSamples: chartSamples
                    )
                    .transition(
                        .opacity.combined(with: .move(edge: .top))
                    )
                }
            }
        }
        .accessibilityIdentifier(
            DashboardAccessibilityIdentifiers.metricCard(
                kindRawValue: metricReading.kind.rawValue
            )
        )
    }
}
