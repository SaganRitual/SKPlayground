// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

/*
 ContentView:
    SpriteKitView
 
    DashboardView
        PlaygroundStatusView

        CommandView
            ClickToPlaceView
            PlayControlsView

        ConfigurationTabView
            ActionsTabView
                SpaceActionsTabView
                PhysicsActionsTabView
                ActionTokensScrollView

            PhysicsTabView
                PhysicsBodyView
                    PhysicsBodyCategoriesView

                PhysicsFieldView
                    PhysicsFieldSlidersView
 
                PhysicsWorldView
                    EdgeLoopCategoriesView

            ShapeLabView
                ShapeListView
 */

struct ContentView: View {
    @EnvironmentObject var gameController: GameController

    var body: some View {
        HStack(alignment: .top) {
            SpriteKitView()
                .frame(minWidth: 1024, minHeight: 768)

            DashboardView()
        }
        .background(Color(NSColor.tertiarySystemFill))
    }
}

#Preview {
    @StateObject var commandSelection = CommandSelection()
    @StateObject var entityActionsPublisher = EntityActionsPublisher()
    @StateObject var entitySelectionState = EntitySelectionState()
    @StateObject var gameController = GameController()
    @StateObject var physicsBodyState = PhysicsBodyState(preview: true)
    @StateObject var physicsFieldState = PhysicsFieldState()
    @StateObject var playgroundState = PlaygroundState()
    @StateObject var shapeLab = ShapeLab()
    @StateObject var spaceActionsState = SpaceActionsState()

    return ContentView()
        .environmentObject(commandSelection)
        .environmentObject(entitySelectionState)
        .environmentObject(gameController)
        .environmentObject(playgroundState)
        .environmentObject(spaceActionsState)
        .onAppear {
            gameController.postInit(
                commandSelection,
                entityActionsPublisher,
                entitySelectionState,
                physicsBodyState,
                physicsFieldState,
                playgroundState,
                shapeLab,
                spaceActionsState
            )
        }
}
