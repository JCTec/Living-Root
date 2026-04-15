import SwiftUI

struct LRCard<Content: View>: View {
    @Environment(\.colorScheme) private var colorScheme

    private let content: Content

    init(
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(
                LRSpacing.large
            )
            .background(
                LRPalette.surface(
                    for: colorScheme
                )
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: LRRadius.large,
                    style: .continuous
                )
            )
            .overlay {
                RoundedRectangle(
                    cornerRadius: LRRadius.large,
                    style: .continuous
                )
                .stroke(
                    LRPalette.border(
                        for: colorScheme
                    ),
                    lineWidth: 1
                )
            }
    }
}
