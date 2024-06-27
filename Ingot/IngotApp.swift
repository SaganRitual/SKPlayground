// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

final class AppData: ObservableObject {
    @Published var commandSelection = CommandSelection()
    @Published var entityActionsPublisher = EntityActionsPublisher()
    @Published var entitySelectionState = EntitySelectionState()
    @Published var gameController = GameController()
    @Published var physicsBodyState = PhysicsBodyState()
    @Published var physicsMaskCategories = PhysicsMaskCategories()
    @Published var physicsWorldState = PhysicsWorldState()
    @Published var playgroundState = PlaygroundState()
    @Published var spaceActionsState = SpaceActionsState()

    init() {
        gameController.postInit(commandSelection, entityActionsPublisher, entitySelectionState, playgroundState, spaceActionsState)
    }
}

@main
struct IngotApp: App {
    @StateObject var appData = AppData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appData.commandSelection)
                .environmentObject(appData.entityActionsPublisher)
                .environmentObject(appData.entitySelectionState)
                .environmentObject(appData.gameController)
                .environmentObject(appData.physicsBodyState)
                .environmentObject(appData.physicsMaskCategories)
                .environmentObject(appData.physicsWorldState)
                .environmentObject(appData.playgroundState)
                .environmentObject(appData.spaceActionsState)
        }
    }
}
