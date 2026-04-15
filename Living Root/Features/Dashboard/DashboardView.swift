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
                    header

                    if let cacheMessage = viewModel.cacheMessage {
                        LRInlineBanner(
                            message: cacheMessage
                        )
                    }

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
                            viewModel.isMetricOrderSheetPresented = true
                        }
                        .font(.subheadline.weight(.semibold))
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

                    Text("Updated: \(viewModel.lastUpdatedText)")
                        .font(.caption)
                        .foregroundStyle(
                            LRPalette.textSecondary(
                                for: colorScheme
                            )
                        )
                        .padding(.top, LRSpacing.small)
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

    private var header: some View {
        HStack {
            VStack(
                alignment: .leading,
                spacing: LRSpacing.xSmall
            ) {
                Text("LivingRoot")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(
                        LRPalette.textPrimary(
                            for: colorScheme
                        )
                    )

                Text("Smart System Monitor")
                    .font(.footnote)
                    .foregroundStyle(
                        LRPalette.textSecondary(
                            for: colorScheme
                        )
                    )
            }

            Spacer()

            LRStateBadge(
                title: viewModel.systemState.title,
                tone: viewModel.stateTone()
            )
        }
    }
}
