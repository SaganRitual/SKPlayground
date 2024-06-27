// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsTabView: View {
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var playgroundState: PlaygroundState

    func exactlyOneFieldSelected() -> Bool {
        playgroundState.selectionState == .one && gameController.getSelected().first is Field
    }

    func exactlyOneGremlinSelected() -> Bool {
        playgroundState.selectionState == .one && gameController.getSelected().first is Gremlin
    }

    var body: some View {
        VStack {
            TabView {
                if exactlyOneGremlinSelected() {
                    PhysicsBodyView()
                        .padding()
                        .tabItem {
                            Label("Body", systemImage: "atom")
                        }
                }

                if exactlyOneFieldSelected() {
                    PhysicsFieldView()
                        .padding()
                        .tabItem {
                            Label("Field", systemImage: "atom")
                        }
                }

                PhysicsWorldView()
                    .tabItem {
                        Label("World", systemImage: "globe")
                    }
            }
        }
        .frame(width: 750, height: 500)
    }
}

#Preview {
    PhysicsTabView()
        .environmentObject(PlaygroundState())
}
