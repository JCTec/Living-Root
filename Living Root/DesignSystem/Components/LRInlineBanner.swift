import SwiftUI

struct LRInlineBanner: View {
    let message: String

    var body: some View {
        HStack(
            spacing: LRSpacing.small
        ) {
            Image(systemName: "wifi.exclamationmark")
                .font(.caption.weight(.bold))
            Text(message)
                .font(.footnote)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        }
        .foregroundStyle(
            Color.black.opacity(0.84)
        )
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding(.horizontal, LRSpacing.medium)
        .padding(.vertical, LRSpacing.small)
        .background(
            LRPalette.banner.opacity(0.32)
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: LRRadius.medium,
                style: .continuous
            )
        )
    }
}
