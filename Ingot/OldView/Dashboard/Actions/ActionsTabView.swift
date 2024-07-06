// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ActionsTabView: View {
    var body: some View {
        VStack {
            TabView {
                SpaceActionsTabView()
                    .tabItem {
                        Label("Space Actions", systemImage: "globe")
                    }

                PhysicsActionsTabView()
                    .tabItem {
                        Label("Physics Actions", systemImage: "atom")
                    }
            }

            ActionTokensScrollView()
                .frame(maxWidth: .infinity)
                .border(.black, width: 2)
        }
        .frame(width: 750, height: 500)
    }
}

#Preview {
    ActionsTabView()
}
