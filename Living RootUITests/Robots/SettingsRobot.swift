import XCTest

final class SettingsRobot {
    private let app: XCUIApplication

    private var rootView: XCUIElement {
        app.collectionViews[SettingsUITestIdentifiers.rootView]
    }

    private var refreshNowButton: XCUIElement {
        app.buttons[SettingsUITestIdentifiers.refreshNowButton]
    }

    private var signOutButton: XCUIElement {
        app.buttons[SettingsUITestIdentifiers.signOutButton]
    }

    private var demoModeToggle: XCUIElement {
        app.switches[SettingsUITestIdentifiers.demoModeToggle]
    }

    private var forceOfflineToggle: XCUIElement {
        app.switches[SettingsUITestIdentifiers.forceOfflineToggle]
    }

    private var designSystemShowcaseLink: XCUIElement {
        app.descendants(
            matching: .any
        )[SettingsUITestIdentifiers.designSystemShowcaseLink]
    }

    init(app: XCUIApplication) {
        self.app = app
    }

    @discardableResult
    func verifyViewIsLoaded(
        timeout: TimeInterval = 8
    ) -> Self {
        XCTAssertTrue(
            rootView.waitForExistence(timeout: timeout),
            "Expected settings root view to exist."
        )

        return self
    }

    @discardableResult
    func tapRefreshNow(
        timeout: TimeInterval = 8
    ) -> Self {
        XCTAssertTrue(
            refreshNowButton.waitForExistence(timeout: timeout),
            "Expected Refresh now button to exist."
        )

        refreshNowButton.tap()

        return self
    }

    @discardableResult
    func signOut(
        timeout: TimeInterval = 8
    ) -> Self {
        XCTAssertTrue(
            signOutButton.waitForExistence(timeout: timeout),
            "Expected Sign Out button to exist."
        )

        signOutButton.tap()

        return self
    }

    @discardableResult
    func verifyUnitPickersExist(
        timeout: TimeInterval = 8
    ) -> Self {
        let temperatureLabel = app.staticTexts["Temperature"]
        let conductivityLabel = app.staticTexts["Conductivity"]

        XCTAssertTrue(
            temperatureLabel.waitForExistence(timeout: timeout),
            "Expected temperature picker to exist."
        )
        XCTAssertTrue(
            conductivityLabel.waitForExistence(timeout: timeout),
            "Expected conductivity picker to exist."
        )

        return self
    }

    @discardableResult
    func toggleDemoMode(
        timeout: TimeInterval = 8
    ) -> Self {
        XCTAssertTrue(
            demoModeToggle.waitForExistence(timeout: timeout),
            "Expected demo mode toggle to exist."
        )
        demoModeToggle.tap()
        return self
    }

    @discardableResult
    func toggleForceOffline(
        timeout: TimeInterval = 8
    ) -> Self {
        XCTAssertTrue(
            forceOfflineToggle.waitForExistence(timeout: timeout),
            "Expected force offline toggle to exist."
        )
        forceOfflineToggle.tap()
        return self
    }

    @discardableResult
    func openDesignSystemShowcaseAndGoBack(
        timeout: TimeInterval = 8
    ) -> Self {
        XCTAssertTrue(
            designSystemShowcaseLink.waitForExistence(timeout: timeout),
            "Expected Design System Showcase link to exist."
        )
        designSystemShowcaseLink.tap()

        let showcaseTitle = app.navigationBars["Showcase"]
        XCTAssertTrue(
            showcaseTitle.waitForExistence(timeout: timeout),
            "Expected Showcase screen to open."
        )

        app.navigationBars.buttons.element(boundBy: 0).tap()

        return self
    }
}
