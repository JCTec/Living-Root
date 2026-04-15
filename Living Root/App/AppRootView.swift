import SwiftUI

struct AppRootView: View {
    let dependencies: AppDependencies

    @State private var dashboardViewModel: DashboardViewModel
    @State private var insightsViewModel: InsightsViewModel
    @State private var alertsViewModel: AlertsViewModel
    @State private var settingsViewModel: SettingsViewModel
    @State private var hasBootstrapped = false

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
        _dashboardViewModel = State(
            initialValue: DashboardViewModel(
                dependencies: dependencies
            )
        )
        _insightsViewModel = State(
            initialValue: InsightsViewModel(
                dependencies: dependencies
            )
        )
        _alertsViewModel = State(
            initialValue: AlertsViewModel(
                dependencies: dependencies
            )
        )
        _settingsViewModel = State(
            initialValue: SettingsViewModel(
                dependencies: dependencies
            )
        )
    }

    var body: some View {
        TabView {
            DashboardView(
                viewModel: dashboardViewModel
            )
            .tabItem {
                Label(
                    "Dashboard",
                    systemImage: "gauge.with.dots.needle.67percent"
                )
            }

            InsightsView(
                viewModel: insightsViewModel
            )
            .tabItem {
                Label(
                    "Insights",
                    systemImage: "lightbulb"
                )
            }

            alertsTab

            SettingsView(
                viewModel: settingsViewModel
            )
            .tabItem {
                Label(
                    "Settings",
                    systemImage: "gearshape"
                )
            }
        }
        .task {
            guard !hasBootstrapped else {
                return
            }
            hasBootstrapped = true
            await dependencies.refreshSnapshot(
                forceRefresh: false
            )
        }
    }

    @ViewBuilder
    private var alertsTab: some View {
        let unreadCount = dependencies.monitoringRepository.unreadAlertCount
        let baseAlertsView = AlertsView(
            viewModel: alertsViewModel
        )
        .tabItem {
            Label(
                "Alerts",
                systemImage: "bell"
            )
        }

        if unreadCount > 0 {
            baseAlertsView.badge(unreadCount)
        } else {
            baseAlertsView
        }
    }
}
