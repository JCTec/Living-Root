import SwiftUI

extension AlertsView {
    struct AlertCard: View {
        let alert: AlertItem
        let onTap: () -> Void

        @Environment(\.colorScheme) private var colorScheme

        var body: some View {
            LRCard {
                HStack(
                    alignment: .top,
                    spacing: LRSpacing.medium
                ) {
                    unreadIndicator

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

                    Spacer()
                }
            }
            .onTapGesture {
                onTap()
            }
        }

        private var unreadIndicator: some View {
            Circle()
                .fill(
                    alert.isUnread ? LRPalette.accent : LRPalette.border(for: colorScheme)
                )
                .frame(
                    width: 10,
                    height: 10
                )
                .padding(.top, LRSpacing.small)
        }
    }
}
