// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ConfigurationTabView: View {
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var playgroundState: PlaygroundState

    var body: some View {
        VStack {
            Text("Configuration")
                .underline()
                .padding(.vertical)

            TabView {
                if playgroundState.selectionState == .one &&
                    gameController.getSelected().first is Gremlin {
                    ActionsTabView()
                        .tabItem {
                            Label("Actions", systemImage: "atom")
                        }
                }

                PhysicsTabView()
                    .tabItem {
                        Label("Physics", systemImage: "atom")
                    }
            }
        }
        .frame(width: 800, height: 600)
    }
}

#Preview {
    ConfigurationTabView()
}
