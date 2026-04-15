import SwiftUI

extension DashboardView {
    struct LastUpdatedLabel: View {
        let text: String

        @Environment(\.colorScheme) private var colorScheme

        var body: some View {
            Text("Updated: \(text)")
                .font(.caption)
                .foregroundStyle(
                    LRPalette.textSecondary(
                        for: colorScheme
                    )
                )
                .padding(.top, LRSpacing.small)
        }
    }
}
