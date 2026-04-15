import SwiftUI

struct DashboardView: View {
    @Bindable var viewModel: DashboardViewModel

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(
                    alignment: .leading,
                    spacing: LRSpacing.large
                ) {
                    Header(
                        systemStateTitle: viewModel.systemState.title,
                        tone: viewModel.stateTone()
                    )

                    if let cacheMessage = viewModel.cacheMessage {
                        LRInlineBanner(
                            message: cacheMessage
                        )
                    }

                    MetricsHeader {
                            viewModel.isMetricOrderSheetPresented = true
                    }

                    ForEach(
                        viewModel.orderedMetrics
                    ) { metricReading in
                        DashboardMetricCardView(
                            metricReading: metricReading,
                            selectedRange: $viewModel.selectedRange,
                            isExpanded: viewModel.isExpanded(
                                for: metricReading.kind
                            ),
                            valueText: viewModel.displayValue(
                                for: metricReading
                            ),
                            unitText: viewModel.displayUnit(
                                for: metricReading.kind
                            ),
                            chartSamples: viewModel.chartSamples(
                                for: metricReading
                            ),
                            toggleExpansion: {
                                viewModel.toggleExpansion(
                                    for: metricReading.kind
                                )
                            }
                        )
                    }

                    LastUpdatedLabel(
                        text: viewModel.lastUpdatedText
                    )
                }
                .padding(.horizontal, LRSpacing.large)
                .padding(.vertical, LRSpacing.large)
            }
            .background(
                LRPalette.background(
                    for: colorScheme
                )
                .ignoresSafeArea()
            )
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.inline)
            .refreshable {
                await viewModel.refresh()
            }
            .task {
                await viewModel.loadIfNeeded()
            }
            .sheet(
                isPresented: $viewModel.isMetricOrderSheetPresented
            ) {
                DashboardMetricOrderSheet(
                    viewModel: viewModel
                )
            }
        }
    }
}
