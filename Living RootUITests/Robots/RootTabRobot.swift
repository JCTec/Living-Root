import XCTest

final class RootTabRobot {
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    @discardableResult
    func verifyTabsAreVisible(
        timeout: TimeInterval = 8
    ) -> Self {
        let dashboardTab = app.tabBars.buttons["Dashboard"]
        let insightsTab = app.tabBars.buttons["Insights"]
        let alertsTab = app.tabBars.buttons["Alerts"]
        let settingsTab = app.tabBars.buttons["Settings"]

        XCTAssertTrue(
            dashboardTab.waitForExistence(timeout: timeout),
            "Expected Dashboard tab to exist."
        )
        XCTAssertTrue(
            insightsTab.waitForExistence(timeout: timeout),
            "Expected Insights tab to exist."
        )
        XCTAssertTrue(
            alertsTab.waitForExistence(timeout: timeout),
            "Expected Alerts tab to exist."
        )
        XCTAssertTrue(
            settingsTab.waitForExistence(timeout: timeout),
            "Expected Settings tab to exist."
        )

        return self
    }

    @discardableResult
    func openDashboard() -> DashboardRobot {
        app.tabBars.buttons["Dashboard"].tap()
        return DashboardRobot(app: app)
    }

    @discardableResult
    func openInsights() -> InsightsRobot {
        app.tabBars.buttons["Insights"].tap()
        return InsightsRobot(app: app)
    }

    @discardableResult
    func openAlerts() -> AlertsRobot {
        app.tabBars.buttons["Alerts"].tap()
        return AlertsRobot(app: app)
    }

    @discardableResult
    func openSettings() -> SettingsRobot {
        app.tabBars.buttons["Settings"].tap()
        return SettingsRobot(app: app)
    }
}
