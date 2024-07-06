// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsTabView: View {
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var entitySelectionState: EntitySelectionState

    func exactlyOneFieldSelected() -> Bool {
        entitySelectionState.selectionState == .one && gameController.getSelected().first is Field
    }

    func exactlyOneGremlinSelected() -> Bool {
        entitySelectionState.selectionState == .one && gameController.getSelected().first is Gremlin
    }

    var body: some View {
        VStack {
            TabView {
                OldPhysicsBodyView()
                    .padding()
                    .tabItem {
                        Label("Body", systemImage: "atom")
                    }

                PhysicsFieldView()
                    .padding()
                    .tabItem {
                        Label("Field", systemImage: "atom")
                    }

                OldPhysicsWorldView()
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
        .environmentObject(GameController())
        .environmentObject(EntitySelectionState())
}
