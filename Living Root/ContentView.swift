import SwiftUI

struct ContentView: View {
    let dependencies: AppDependencies

    var body: some View {
        AppRootView(
            dependencies: dependencies
        )
    }
}
