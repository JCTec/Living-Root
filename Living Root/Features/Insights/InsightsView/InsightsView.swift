import SwiftUI

struct InsightsView: View {
    @Bindable var viewModel: InsightsViewModel

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(
                    alignment: .leading,
                    spacing: LRSpacing.large
                ) {
                    if let cacheMessage = viewModel.cacheMessage {
                        LRInlineBanner(
                            message: cacheMessage
                        )
                    }

                    if viewModel.insights.isEmpty {
                        EmptyStateCard()
                        .frame(maxWidth: .infinity)
                    } else {
                        ForEach(
                            viewModel.insights
                        ) { insight in
                            InsightCard(
                                insight: insight
                            )
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding(.vertical, LRSpacing.large)
            }
            .background(
                LRPalette.background(
                    for: colorScheme
                )
                .ignoresSafeArea()
            )
            .navigationTitle("Insights")
            .navigationBarTitleDisplayMode(.inline)
            .refreshable {
                await viewModel.refresh()
            }
            .task {
                await viewModel.loadIfNeeded()
            }
        }
    }
}
