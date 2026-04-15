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

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        LRCard {
            VStack(
                spacing: LRSpacing.medium
            ) {
                header

                if isExpanded {
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

                        chartView
                    }
                    .transition(
                        .opacity.combined(with: .move(edge: .top))
                    )
                }
            }
        }
    }

    private var header: some View {
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

    private var chartView: some View {
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
