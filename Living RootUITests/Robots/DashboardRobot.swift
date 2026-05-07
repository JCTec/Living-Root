import XCTest

final class DashboardRobot {
    private let app: XCUIApplication

    private var rootView: XCUIElement {
        app.scrollViews[DashboardUITestIdentifiers.rootView]
    }

    private var changeOrderButton: XCUIElement {
        app.buttons[DashboardUITestIdentifiers.changeOrderButton]
    }

    private var metricOrderDoneButton: XCUIElement {
        app.buttons[DashboardUITestIdentifiers.metricOrderSheetDoneButton]
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
            "Expected dashboard root view to exist."
        )

        return self
    }

    @discardableResult
    func verifyMetricCardExists(
        kindRawValue: String,
        timeout: TimeInterval = 8
    ) -> Self {
        let card = element(
            identifier: DashboardUITestIdentifiers.metricCard(
                kindRawValue: kindRawValue
            )
        )

        XCTAssertTrue(
            card.waitForExistence(timeout: timeout),
            "Expected metric card for \(kindRawValue) to exist."
        )

        return self
    }

    @discardableResult
    func toggleMetricCardExpansion(
        kindRawValue: String,
        timeout: TimeInterval = 8
    ) -> Self {
        let headerButton = element(
            identifier: DashboardUITestIdentifiers.metricCardHeaderButton(
                kindRawValue: kindRawValue
            )
        )
        let fallbackButton = app.buttons.matching(
            NSPredicate(
                format: "label CONTAINS[c] %@",
                metricTitle(
                    for: kindRawValue
                )
            )
        ).firstMatch
        let targetButton = headerButton.exists ? headerButton : fallbackButton

        XCTAssertTrue(
            targetButton.waitForExistence(timeout: timeout),
            "Expected metric header button for \(kindRawValue) to exist."
        )

        targetButton.tap()

        return self
    }

    @discardableResult
    func verifyRangeSegmentsAreVisible(
        timeout: TimeInterval = 8
    ) -> Self {
        let day24Segment = app.buttons["24h"]
        let day7Segment = app.buttons["7d"]

        XCTAssertTrue(
            day24Segment.waitForExistence(timeout: timeout),
            "Expected 24h range segment to exist."
        )
        XCTAssertTrue(
            day7Segment.waitForExistence(timeout: timeout),
            "Expected 7d range segment to exist."
        )

        return self
    }

    @discardableResult
    func openMetricOrderSheet(
        timeout: TimeInterval = 8
    ) -> Self {
        XCTAssertTrue(
            changeOrderButton.waitForExistence(timeout: timeout),
            "Expected Change Order button to exist."
        )

        changeOrderButton.tap()

        return self
    }

    @discardableResult
    func closeMetricOrderSheet(
        timeout: TimeInterval = 8
    ) -> Self {
        XCTAssertTrue(
            metricOrderDoneButton.waitForExistence(timeout: timeout),
            "Expected Done button in metric order sheet to exist."
        )

        metricOrderDoneButton.tap()

        return self
    }

    private func element(
        identifier: String
    ) -> XCUIElement {
        app.descendants(
            matching: .any
        )[identifier]
    }

    private func metricTitle(
        for kindRawValue: String
    ) -> String {
        switch kindRawValue {
        case "ph":
            return "pH"
        case "ec":
            return "EC"
        case "waterTemperature":
            return "Water Temperature"
        case "waterLevel":
            return "Water Level"
        default:
            return kindRawValue
        }
    }
}
