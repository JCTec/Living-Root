import SwiftUI

enum LRPalette {
    static func background(
        for colorScheme: ColorScheme
    ) -> Color {
        colorScheme == .dark
            ? Color(
                red: 0.07,
                green: 0.09,
                blue: 0.11
            )
            : Color(
                red: 0.95,
                green: 0.97,
                blue: 0.98
            )
    }

    static func surface(
        for colorScheme: ColorScheme
    ) -> Color {
        colorScheme == .dark
            ? Color(
                red: 0.12,
                green: 0.15,
                blue: 0.18
            )
            : Color.white
    }

    static func border(
        for colorScheme: ColorScheme
    ) -> Color {
        colorScheme == .dark
            ? Color.white.opacity(0.12)
            : Color.black.opacity(0.08)
    }

    static func textPrimary(
        for colorScheme: ColorScheme
    ) -> Color {
        colorScheme == .dark ? .white : .black
    }

    static func textSecondary(
        for colorScheme: ColorScheme
    ) -> Color {
        colorScheme == .dark
            ? Color.white.opacity(0.72)
            : Color.black.opacity(0.58)
    }

    static let accent = Color(
        red: 0.14,
        green: 0.52,
        blue: 0.83
    )

    static let success = Color(
        red: 0.20,
        green: 0.68,
        blue: 0.34
    )

    static let warning = Color(
        red: 0.94,
        green: 0.62,
        blue: 0.18
    )

    static let critical = Color(
        red: 0.89,
        green: 0.23,
        blue: 0.22
    )

    static let banner = Color(
        red: 0.95,
        green: 0.76,
        blue: 0.10
    )
}
