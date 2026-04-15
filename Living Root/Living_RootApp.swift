import SwiftData
import SwiftUI

@main
struct LivingRootApp: App {
    @State private var appDependencies: AppDependencies

    init() {
        _appDependencies = State(
            initialValue: AppDependencies.makeLive()
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView(
                dependencies: appDependencies
            )
            .environment(
                appDependencies
            )
            .modelContainer(
                appDependencies.modelContainer
            )
        }
    }
}
