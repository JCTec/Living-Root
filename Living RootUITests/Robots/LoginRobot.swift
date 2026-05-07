import XCTest

final class LoginRobot {
    private let app: XCUIApplication

    private var rootView: XCUIElement {
        app.scrollViews[LoginUITestIdentifiers.rootView]
    }

    private var usernameTextField: XCUIElement {
        app.textFields[LoginUITestIdentifiers.usernameTextField]
    }

    private var passwordTextField: XCUIElement {
        app.secureTextFields[LoginUITestIdentifiers.passwordTextField]
    }

    private var signInButton: XCUIElement {
        app.buttons[LoginUITestIdentifiers.signInButton]
    }

    private var useDevCredentialsButton: XCUIElement {
        app.buttons[LoginUITestIdentifiers.useDevelopmentCredentialsButton]
    }

    init(app: XCUIApplication) {
        self.app = app
    }

    @discardableResult
    func verifyViewIsLoaded(
        timeout: TimeInterval = 5
    ) -> Self {
        XCTAssertTrue(
            rootView.waitForExistence(timeout: timeout),
            "Expected login root view to exist."
        )

        return self
    }

    @discardableResult
    func typeUsername(
        _ value: String,
        timeout: TimeInterval = 5
    ) -> Self {
        XCTAssertTrue(
            usernameTextField.waitForExistence(timeout: timeout),
            "Expected username field to exist."
        )

        usernameTextField.tap()
        usernameTextField.typeText(value)

        return self
    }

    @discardableResult
    func typePassword(
        _ value: String,
        timeout: TimeInterval = 5
    ) -> Self {
        XCTAssertTrue(
            passwordTextField.waitForExistence(timeout: timeout),
            "Expected password field to exist."
        )

        passwordTextField.tap()
        passwordTextField.typeText(value)

        return self
    }

    @discardableResult
    func tapSignIn(
        timeout: TimeInterval = 5
    ) -> Self {
        XCTAssertTrue(
            signInButton.waitForExistence(timeout: timeout),
            "Expected sign-in button to exist."
        )

        signInButton.tap()

        return self
    }

    @discardableResult
    func useDevelopmentCredentials(
        timeout: TimeInterval = 5
    ) -> Self {
        XCTAssertTrue(
            useDevCredentialsButton.waitForExistence(timeout: timeout),
            "Expected use development credentials button to exist in DEBUG."
        )

        useDevCredentialsButton.tap()

        return self
    }

    @discardableResult
    func signInAsDevelopmentUser() -> Self {
        useDevelopmentCredentials()
        tapSignIn()
        return self
    }
}
