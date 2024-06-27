// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ContentView: View {
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
    @StateObject var entitySelectionState = EntitySelectionState()
    @StateObject var gameController = GameController()
    @StateObject var playgroundState = PlaygroundState()
    @StateObject var spaceActionsState = SpaceActionsState()

    return ContentView()
        .environmentObject(commandSelection)
        .environmentObject(entitySelectionState)
        .environmentObject(gameController)
        .environmentObject(playgroundState)
        .environmentObject(spaceActionsState)
        .onAppear() {
            gameController.postInit(
                commandSelection,
                entitySelectionState,
                playgroundState,
                spaceActionsState
            )
        }
}
