import XCTest

final class AuthFlowUITests: LRUITestCase {
    @MainActor
    func testUserCanSignInWithDevelopmentCredentials() {
        LoginRobot(app: app)
            .verifyViewIsLoaded()
            .signInAsDevelopmentUser()

        RootTabRobot(app: app)
            .verifyTabsAreVisible()
    }

    @MainActor
    func testInvalidCredentialsShowErrorMessage() {
        LoginRobot(app: app)
            .verifyViewIsLoaded()
            .typeUsername("wrong-user")
            .typePassword("wrong-pass")
            .tapSignIn()

        let errorLabel = app.staticTexts[LoginUITestIdentifiers.errorMessage]
        XCTAssertTrue(
            errorLabel.waitForExistence(timeout: 5),
            "Expected login error message to appear for invalid credentials."
        )
    }
}
