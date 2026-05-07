import XCTest

enum AppLauncher {
    static func makeApp(
        resetState: Bool = true
    ) -> XCUIApplication {
        let app = XCUIApplication()

        if resetState {
            app.launchArguments.append(
                "--uitest-reset-state"
            )
        }

        return app
    }
}
