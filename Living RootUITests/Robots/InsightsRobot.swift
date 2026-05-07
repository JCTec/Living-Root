import XCTest

final class InsightsRobot {
    private let app: XCUIApplication

    private var rootView: XCUIElement {
        app.scrollViews[InsightsUITestIdentifiers.rootView]
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
            "Expected insights root view to exist."
        )

        return self
    }
}
