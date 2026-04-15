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
                        LRCard {
                            Text("No insights available yet.")
                                .font(.body)
                                .foregroundStyle(
                                    LRPalette.textSecondary(
                                        for: colorScheme
                                    )
                                )
                        }
                        .frame(maxWidth: .infinity)
                    } else {
                        ForEach(
                            viewModel.insights
                        ) { insight in
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
