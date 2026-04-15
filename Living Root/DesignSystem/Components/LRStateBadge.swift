import SwiftUI

enum LRStatusTone {
    case positive
    case caution
    case critical
}

struct LRStateBadge: View {
    let title: String
    let tone: LRStatusTone

    var body: some View {
        Text(title)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, LRSpacing.medium)
            .padding(.vertical, LRSpacing.small)
            .foregroundStyle(
                Color.white
            )
            .background(
                toneColor
            )
            .clipShape(
                Capsule(style: .continuous)
            )
            .accessibilityLabel(
                "System state \(title)"
            )
    }

    private var toneColor: Color {
        switch tone {
        case .positive:
            return LRPalette.success
        case .caution:
            return LRPalette.warning
        case .critical:
            return LRPalette.critical
        }
    }
}
