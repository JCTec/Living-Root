import XCTest

class LRUITestCase: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = AppLauncher.makeApp()
        app.launch()
    }

    @discardableResult
    func signInAsDevelopmentUser() -> RootTabRobot {
        LoginRobot(app: app)
            .verifyViewIsLoaded()
            .signInAsDevelopmentUser()

        let rootTabRobot = RootTabRobot(app: app)
        rootTabRobot.verifyTabsAreVisible()

        return rootTabRobot
    }
}
