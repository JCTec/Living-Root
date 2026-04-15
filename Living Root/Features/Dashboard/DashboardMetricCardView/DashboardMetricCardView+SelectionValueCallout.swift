import SwiftUI

extension DashboardMetricCardView {
    struct SelectionValueCallout: View {
        let valueText: String

        @Environment(\.colorScheme) private var colorScheme

        var body: some View {
            VStack(
                spacing: 0
            ) {
                Text(valueText)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(
                        LRPalette.textPrimary(
                            for: colorScheme
                        )
                    )
                    .padding(.horizontal, LRSpacing.small)
                    .padding(.vertical, LRSpacing.xSmall)
                    .background(
                        RoundedRectangle(
                            cornerRadius: LRRadius.small
                        )
                        .fill(
                            LRPalette.surface(
                                for: colorScheme
                            )
                        )
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: LRRadius.small
                            )
                            .stroke(
                                LRPalette.border(
                                    for: colorScheme
                                ),
                                lineWidth: 1
                            )
                        )
                    )

                SelectionCalloutPointer()
                    .fill(
                        LRPalette.surface(
                            for: colorScheme
                        )
                    )
                    .frame(
                        width: 12,
                        height: 7
                    )
                    .overlay(
                        SelectionCalloutPointer()
                            .stroke(
                                LRPalette.border(
                                    for: colorScheme
                                ),
                                lineWidth: 1
                            )
                    )
                    .offset(y: -1)
            }
        }
    }

    struct SelectionCalloutPointer: Shape {
        func path(
            in rect: CGRect
        ) -> Path {
            var path = Path()
            path.move(
                to: CGPoint(
                    x: rect.midX,
                    y: rect.maxY
                )
            )
            path.addLine(
                to: CGPoint(
                    x: rect.minX,
                    y: rect.minY
                )
            )
            path.addLine(
                to: CGPoint(
                    x: rect.maxX,
                    y: rect.minY
                )
            )
            path.closeSubpath()
            return path
        }
    }
}
