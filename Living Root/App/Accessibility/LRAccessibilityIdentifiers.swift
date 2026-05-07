import Foundation

enum AppRootAccessibilityIdentifiers {
    static let tabBar = "app_root_tab_bar"
    static let dashboardTab = "app_root_tab_dashboard"
    static let insightsTab = "app_root_tab_insights"
    static let alertsTab = "app_root_tab_alerts"
    static let settingsTab = "app_root_tab_settings"
}

enum LoginAccessibilityIdentifiers {
    static let rootView = "login_root_view"
    static let usernameTextField = "login_username_text_field"
    static let passwordTextField = "login_password_text_field"
    static let useDevelopmentCredentialsButton = "login_use_dev_credentials_button"
    static let signInButton = "login_sign_in_button"
    static let errorMessage = "login_error_message"
}

enum DashboardAccessibilityIdentifiers {
    static let rootView = "dashboard_root_view"
    static let changeOrderButton = "dashboard_change_order_button"
    static let metricOrderSheetDoneButton = "dashboard_metric_order_done_button"
    static let metricOrderList = "dashboard_metric_order_list"

    static func metricCard(
        kindRawValue: String
    ) -> String {
        "dashboard_metric_card_\(kindRawValue)"
    }

    static func metricCardHeaderButton(
        kindRawValue: String
    ) -> String {
        "dashboard_metric_card_header_button_\(kindRawValue)"
    }

    static func metricRangePicker(
        kindRawValue: String
    ) -> String {
        "dashboard_metric_range_picker_\(kindRawValue)"
    }

    static func metricChart(
        kindRawValue: String
    ) -> String {
        "dashboard_metric_chart_\(kindRawValue)"
    }
}

enum InsightsAccessibilityIdentifiers {
    static let rootView = "insights_root_view"
    static let emptyStateCard = "insights_empty_state_card"

    static func insightCard(
        id: UUID
    ) -> String {
        "insights_card_\(id.uuidString.lowercased())"
    }
}

enum AlertsAccessibilityIdentifiers {
    static let rootView = "alerts_root_view"
    static let markAllReadButton = "alerts_mark_all_read_button"
    static let emptyStateCard = "alerts_empty_state_card"

    static func alertCard(
        id: UUID
    ) -> String {
        "alerts_card_\(id.uuidString.lowercased())"
    }
}

enum SettingsAccessibilityIdentifiers {
    static let rootView = "settings_root_view"
    static let signOutButton = "settings_sign_out_button"
    static let refreshNowButton = "settings_refresh_now_button"
    static let temperaturePicker = "settings_temperature_picker"
    static let conductivityPicker = "settings_conductivity_picker"
    static let demoModeToggle = "settings_demo_mode_toggle"
    static let forceOfflineToggle = "settings_force_offline_toggle"
    static let designSystemShowcaseLink = "settings_design_system_showcase_link"
}
