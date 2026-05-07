import XCTest

final class TabsAndSectionsUITests: LRUITestCase {
    @MainActor
    func testUserCanNavigateAllTopLevelTabs() {
        let rootTabs = signInAsDevelopmentUser()

        rootTabs.openDashboard()
            .verifyViewIsLoaded()

        rootTabs.openInsights()
            .verifyViewIsLoaded()

        rootTabs.openAlerts()
            .verifyViewIsLoaded()

        rootTabs.openSettings()
            .verifyViewIsLoaded()
    }

    @MainActor
    func testSettingsRefreshAndSignOutFlow() {
        let rootTabs = signInAsDevelopmentUser()

        rootTabs.openSettings()
            .verifyViewIsLoaded()
            .tapRefreshNow()
            .signOut()

        LoginRobot(app: app)
            .verifyViewIsLoaded()
    }
}
