import XCTest

final class DashboardUITests: LRUITestCase {
    @MainActor
    func testDashboardMetricCardCanExpand() {
        signInAsDevelopmentUser()
            .openDashboard()
            .verifyViewIsLoaded()
            .verifyMetricCardExists(kindRawValue: "ph")
            .toggleMetricCardExpansion(kindRawValue: "ph")
            .verifyRangeSegmentsAreVisible()
    }

    @MainActor
    func testDashboardMetricOrderSheetCanOpenAndClose() {
        signInAsDevelopmentUser()
            .openDashboard()
            .verifyViewIsLoaded()
            .openMetricOrderSheet()
            .closeMetricOrderSheet()
    }
}
