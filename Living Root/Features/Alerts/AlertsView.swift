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
                    } else {
                        ForEach(
                            viewModel.alerts
                        ) { alert in
                            alertCard(alert)
                                .onTapGesture {
                                    if alert.isUnread {
                                        viewModel.markAsRead(
                                            alertID: alert.id
                                        )
                                    }
                                }
                        }
                    }
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

    private func alertCard(
        _ alert: AlertItem
    ) -> some View {
        LRCard {
            HStack(
                alignment: .top,
                spacing: LRSpacing.medium
            ) {
                unreadIndicator(
                    isUnread: alert.isUnread
                )

                alertDetails(alert)

                Spacer()
            }
        }
    }

    private func unreadIndicator(
        isUnread: Bool
    ) -> some View {
        Circle()
            .fill(
                isUnread ? LRPalette.accent : LRPalette.border(for: colorScheme)
            )
            .frame(
                width: 10,
                height: 10
            )
            .padding(.top, LRSpacing.small)
    }

    private func alertDetails(
        _ alert: AlertItem
    ) -> some View {
        VStack(
            alignment: .leading,
            spacing: LRSpacing.xSmall
        ) {
            Text(alert.title)
                .font(.headline)
                .foregroundStyle(
                    LRPalette.textPrimary(
                        for: colorScheme
                    )
                )

            Text(alert.message)
                .font(.body)
                .foregroundStyle(
                    LRPalette.textSecondary(
                        for: colorScheme
                    )
                )

            Text(
                alert.timestamp.formatted(
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
}
