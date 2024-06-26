// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

final class AppData: ObservableObject {
    @Published var gameController = GameController()
    @Published var playgroundState = PlaygroundState()

    init() {
        gameController.postInit(playgroundState)
    }
}

@main
struct IngotApp: App {
    @StateObject var appData = AppData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appData.gameController)
                .environmentObject(appData.playgroundState)
        }
    }
}
