import SwiftUI

struct DesignSystemShowcaseView: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ScrollView {
            VStack(
                alignment: .leading,
                spacing: LRSpacing.large
            ) {
                Text("Design System")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(
                        LRPalette.textPrimary(
                            for: colorScheme
                        )
                    )

                colorSwatchCard
                typographyCard
                componentCard
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
        .navigationTitle("Showcase")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var colorSwatchCard: some View {
        LRCard {
            VStack(
                alignment: .leading,
                spacing: LRSpacing.medium
            ) {
                Text("Color Tokens")
                    .font(.headline)

                HStack(
                    spacing: LRSpacing.small
                ) {
                    swatch(
                        title: "Accent",
                        color: LRPalette.accent
                    )
                    swatch(
                        title: "Success",
                        color: LRPalette.success
                    )
                    swatch(
                        title: "Warning",
                        color: LRPalette.warning
                    )
                    swatch(
                        title: "Critical",
                        color: LRPalette.critical
                    )
                }
            }
        }
    }

    private var typographyCard: some View {
        LRCard {
            VStack(
                alignment: .leading,
                spacing: LRSpacing.small
            ) {
                Text("Typography")
                    .font(.headline)
                Text("Title")
                    .font(.title3.weight(.semibold))
                Text("Body text keeps information calm and readable.")
                    .font(.body)
                Text("Secondary support text.")
                    .font(.footnote)
                    .foregroundStyle(
                        LRPalette.textSecondary(
                            for: colorScheme
                        )
                    )
            }
        }
    }

    private var componentCard: some View {
        LRCard {
            VStack(
                alignment: .leading,
                spacing: LRSpacing.medium
            ) {
                Text("Components")
                    .font(.headline)

                HStack(spacing: LRSpacing.small) {
                    LRStateBadge(
                        title: "Stable",
                        tone: .positive
                    )
                    LRStateBadge(
                        title: "Warning",
                        tone: .caution
                    )
                }

                LRInlineBanner(
                    message: "Cached data displayed while connection is unavailable."
                )
            }
        }
    }

    private func swatch(
        title: String,
        color: Color
    ) -> some View {
        VStack(
            spacing: LRSpacing.xSmall
        ) {
            RoundedRectangle(
                cornerRadius: LRRadius.small,
                style: .continuous
            )
            .fill(color)
            .frame(
                width: 48,
                height: 32
            )

            Text(title)
                .font(.caption2)
        }
        .frame(maxWidth: .infinity)
    }
}
