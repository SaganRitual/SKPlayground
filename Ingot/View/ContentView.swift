// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var playgroundState: PlaygroundState

    var body: some View {
        HStack(alignment: .top) {
            SpriteKitView()

            VStack {
                PlaygroundStatusView()
                    .frame(height: 100)
                    .padding()
                    .background(Color(NSColor.secondarySystemFill))
                    .padding(2)

                CommandView()
                    .frame(height: 100)
                    .padding()
                    .background(Color(NSColor.secondarySystemFill))
                    .padding(2)

                PhysicsTabView()
                    .padding()
                    .background(Color(NSColor.secondarySystemFill))
                    .padding(2)

                if playgroundState.selectionState == .one &&
                    gameController.getSelected().first is Gremlin {

                    ActionsTabView()
                        .border(.black, width: 2)

                    ActionTokensScrollView()
                        .frame(maxWidth: .infinity)
                        .border(.black, width: 2)
                }
            }
            .monospaced()
            .frame(width: 700)
        }
        .background(Color(NSColor.tertiarySystemFill))
    }
}

#Preview {
    @StateObject var ps = PlaygroundState()
    ps.makeTestTokensArray()

    return ContentView()
        .environmentObject(GameController())
        .environmentObject(ps)
}
