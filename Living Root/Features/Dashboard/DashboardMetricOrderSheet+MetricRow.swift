import SwiftUI

extension DashboardMetricOrderSheet {
    struct MetricRow: View {
        let metricKind: MetricKind

        var body: some View {
            HStack(
                spacing: LRSpacing.medium
            ) {
                Image(systemName: metricKind.sfSymbol)
                    .frame(width: 22)
                    .foregroundStyle(LRPalette.accent)

                Text(metricKind.title)
            }
        }
    }
}
