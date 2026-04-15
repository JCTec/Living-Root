import SwiftUI

extension DashboardView {
    struct Header: View {
        let systemStateTitle: String
        let tone: LRStatusTone

        @Environment(\.colorScheme) private var colorScheme

        var body: some View {
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
                    title: systemStateTitle,
                    tone: tone
                )
            }
        }
    }
}
