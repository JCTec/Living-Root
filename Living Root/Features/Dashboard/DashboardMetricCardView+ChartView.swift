import Charts
import SwiftUI

extension DashboardMetricCardView {
    struct ChartView: View {
        @Binding var selectedRange: MetricRange
        let chartSamples: [MetricSample]

        @Environment(\.colorScheme) private var colorScheme

        var body: some View {
            VStack(
                spacing: LRSpacing.medium
            ) {
                Picker(
                    "Range",
                    selection: $selectedRange
                ) {
                    ForEach(
                        MetricRange.allCases
                    ) { range in
                        Text(range.title)
                            .tag(range)
                    }
                }
                .pickerStyle(.segmented)

                Group {
                    if chartSamples.isEmpty {
                        Text("No chart data available")
                            .font(.footnote)
                            .foregroundStyle(
                                LRPalette.textSecondary(
                                    for: colorScheme
                                )
                            )
                    } else {
                        Chart(chartSamples) { sample in
                            AreaMark(
                                x: .value("Time", sample.timestamp),
                                y: .value("Value", sample.value)
                            )
                            .foregroundStyle(
                                LRPalette.accent.opacity(0.16)
                            )

                            LineMark(
                                x: .value("Time", sample.timestamp),
                                y: .value("Value", sample.value)
                            )
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(LRPalette.accent)
                            .lineStyle(
                                StrokeStyle(
                                    lineWidth: 2,
                                    lineCap: .round,
                                    lineJoin: .round
                                )
                            )
                        }
                        .chartLegend(.hidden)
                        .frame(height: 180)
                    }
                }
            }
        }
    }
}
