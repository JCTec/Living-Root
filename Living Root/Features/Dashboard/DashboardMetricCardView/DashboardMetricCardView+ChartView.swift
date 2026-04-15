import Charts
import SwiftUI

extension DashboardMetricCardView {
    struct ChartView: View {
        @Binding var selectedRange: MetricRange
        let chartSamples: [MetricSample]

        @Environment(\.colorScheme) private var colorScheme
        @State private var selectedSampleID: MetricSample.ID?

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
                        interactiveChart
                    }
                }
            }
            .onChange(
                of: chartSamples
            ) { _, newSamples in
                guard let selectedSampleID else {
                    return
                }

                if !newSamples.contains(where: { $0.id == selectedSampleID }) {
                    self.selectedSampleID = nil
                }
            }
        }

        private var interactiveChart: some View {
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

                if let selectedSample {
                    RuleMark(
                        x: .value("Selected Time", selectedSample.timestamp)
                    )
                    .foregroundStyle(
                        LRPalette.border(
                            for: colorScheme
                        )
                    )
                    .lineStyle(
                        StrokeStyle(
                            lineWidth: 1,
                            dash: [4, 4]
                        )
                    )

                    PointMark(
                        x: .value("Selected Time", selectedSample.timestamp),
                        y: .value("Selected Value", selectedSample.value)
                    )
                    .symbol(.circle)
                    .symbolSize(52)
                    .foregroundStyle(LRPalette.accent)
                    .annotation(
                        position: .top,
                        spacing: LRSpacing.small
                    ) {
                        SelectionValueCallout(
                            valueText: selectedSample.value.formatted(
                                .number.precision(
                                    .fractionLength(0...2)
                                )
                            )
                        )
                    }
                }
            }
            .chartLegend(.hidden)
            .chartOverlay { chartProxy in
                GeometryReader { geometry in
                    Rectangle()
                        .fill(.clear)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture(
                                minimumDistance: 0
                            )
                            .onChanged { value in
                                updateSelection(
                                    at: value.location,
                                    chartProxy: chartProxy,
                                    geometry: geometry
                                )
                            }
                        )
                }
            }
            .frame(height: 180)
        }

        private var selectedSample: MetricSample? {
            guard let selectedSampleID else {
                return nil
            }

            return chartSamples.first(where: { $0.id == selectedSampleID })
        }

        private func updateSelection(
            at location: CGPoint,
            chartProxy: ChartProxy,
            geometry: GeometryProxy
        ) {
            guard let plotFrame = chartProxy.plotFrame else {
                return
            }

            let plotAreaFrame = geometry[plotFrame]

            guard plotAreaFrame.contains(location) else {
                return
            }

            let plotAreaX = location.x - plotAreaFrame.origin.x

            guard let selectedDate: Date = chartProxy.value(atX: plotAreaX) else {
                return
            }

            selectedSampleID = nearestSample(to: selectedDate)?.id
        }

        private func nearestSample(
            to date: Date
        ) -> MetricSample? {
            chartSamples.min { leftSample, rightSample in
                abs(
                    leftSample.timestamp.timeIntervalSince(date)
                ) < abs(
                    rightSample.timestamp.timeIntervalSince(date)
                )
            }
        }
    }
}
