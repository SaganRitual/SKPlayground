// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ActionsTabView: View {
    var body: some View {
        VStack {
            Text("Actions")
                .underline()
                .padding(.vertical)
            
            TabView {
                SpaceActionsTabView()
                    .tabItem {
                        Label("Space", systemImage: "globe")
                    }
                    .frame(height: 300)

                PhysicsActionsTabView()
                    .tabItem {
                        Label("Physics", systemImage: "atom")
                    }
                    .frame(height: 300)
            }
        }
        .frame(height: 400)
    }
}

#Preview {
    ActionsTabView()
        .environmentObject(PlaygroundState())
}
