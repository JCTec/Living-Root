import XCTest

final class SettingsAndAlertsUITests: LRUITestCase {
    @MainActor
    func testAlertsMarkAllReadHidesButton() {
        signInAsDevelopmentUser()
            .openAlerts()
            .verifyViewIsLoaded()
            .markAllAsReadAndVerifyHidden()
    }

    @MainActor
    func testSettingsDebugAndUnitControlsAreAccessible() {
        signInAsDevelopmentUser()
            .openSettings()
            .verifyViewIsLoaded()
            .verifyUnitPickersExist()
            .toggleDemoMode()
            .toggleForceOffline()
            .openDesignSystemShowcaseAndGoBack()
    }
}
