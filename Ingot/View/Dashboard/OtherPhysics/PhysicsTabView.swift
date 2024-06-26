// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsTabView: View {
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var playgroundState: PlaygroundState

    func exactlyOneFieldSelected() -> Bool {
        let result = playgroundState.selectionState == .one && gameController.getSelected().first is Field
        print("one field \(result)")
        return result
    }

    func exactlyOneGremlinSelected() -> Bool {
        let result = playgroundState.selectionState == .one && gameController.getSelected().first is Gremlin
        print("one gremlin \(result)")
        return result
    }

    var body: some View {
        VStack {
            Text("Physics")
                .underline()
                .padding(.vertical)

            TabView {
                if exactlyOneGremlinSelected() {
                    PhysicsBodyTabView()
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
        .frame(height: 450)
    }
}

#Preview {
    PhysicsTabView()
        .environmentObject(PlaygroundState())
}
