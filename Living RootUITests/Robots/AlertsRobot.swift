import XCTest

final class AlertsRobot {
    private let app: XCUIApplication

    private var rootView: XCUIElement {
        app.scrollViews[AlertsUITestIdentifiers.rootView]
    }

    private var markAllReadButton: XCUIElement {
        app.buttons[AlertsUITestIdentifiers.markAllReadButton]
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
            "Expected alerts root view to exist."
        )

        return self
    }

    @discardableResult
    func markAllAsReadIfVisible(
        timeout: TimeInterval = 5
    ) -> Self {
        if markAllReadButton.waitForExistence(timeout: timeout) {
            markAllReadButton.tap()
        }

        return self
    }

    @discardableResult
    func markAllAsReadAndVerifyHidden(
        timeout: TimeInterval = 8
    ) -> Self {
        XCTAssertTrue(
            markAllReadButton.waitForExistence(timeout: timeout),
            "Expected Mark all read button to be visible before tapping."
        )

        markAllReadButton.tap()

        XCTAssertFalse(
            markAllReadButton.waitForExistence(timeout: 2),
            "Expected Mark all read button to be hidden after marking all alerts as read."
        )

        return self
    }
}
