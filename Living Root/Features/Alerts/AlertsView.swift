import SwiftUI

struct AlertsView: View {
    @Bindable var viewModel: AlertsViewModel

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

                    if viewModel.alerts.isEmpty {
                        LRCard {
                            Text("No alerts available.")
                                .foregroundStyle(
                                    LRPalette.textSecondary(
                                        for: colorScheme
                                    )
                                )
                        }
                        .accessibilityIdentifier(
                            AlertsAccessibilityIdentifiers.emptyStateCard
                        )
                    } else {
                        ForEach(
                            viewModel.alerts
                        ) { alert in
                            AlertCard(
                                alert: alert,
                                onTap: {
                                    markAlertAsReadIfNeeded(
                                        alert
                                    )
                                }
                            )
                        }
                    }
                }
                .padding(.horizontal, LRSpacing.large)
                .padding(.vertical, LRSpacing.large)
            }
            .accessibilityIdentifier(
                AlertsAccessibilityIdentifiers.rootView
            )
            .background(
                LRPalette.background(
                    for: colorScheme
                )
                .ignoresSafeArea()
            )
            .navigationTitle("Alerts")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if viewModel.unreadCount > 0 {
                    ToolbarItem(
                        placement: .topBarTrailing
                    ) {
                        Button("Mark all read") {
                            viewModel.markAllAsRead()
                        }
                        .accessibilityIdentifier(
                            AlertsAccessibilityIdentifiers.markAllReadButton
                        )
                        .font(.subheadline.weight(.semibold))
                    }
                }
            }
            .refreshable {
                await viewModel.refresh()
            }
            .task {
                await viewModel.loadIfNeeded()
            }
        }
    }

    private func markAlertAsReadIfNeeded(
        _ alert: AlertItem
    ) {
        if alert.isUnread {
            viewModel.markAsRead(
                alertID: alert.id
            )
        }
    }
}
