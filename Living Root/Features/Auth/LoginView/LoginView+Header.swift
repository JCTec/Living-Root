import SwiftUI

extension LoginView {
    struct Header: View {
        @Environment(\.colorScheme) private var colorScheme

        var body: some View {
            VStack(
                alignment: .leading,
                spacing: LRSpacing.small
            ) {
                Text("LivingRoot")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(
                        LRPalette.textPrimary(
                            for: colorScheme
                        )
                    )

                Text("Sign in to monitor your system with a mobile-first experience.")
                    .font(.body)
                    .foregroundStyle(
                        LRPalette.textSecondary(
                            for: colorScheme
                        )
                    )
            }
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
        }
    }
}
