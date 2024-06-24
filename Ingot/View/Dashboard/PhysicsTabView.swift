// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsTabView: View {
    var body: some View {
        VStack {
            Text("Physics")
                .underline()
                .padding(.vertical)

            TabView {
                PhysicsWorldView()
                    .tabItem {
                        Label("World", systemImage: "globe")
                    }
                    .frame(height: 300)

                PhysicsEntityView()
                    .padding()
                    .tabItem {
                        Label("Entity", systemImage: "atom")
                    }
                    .frame(height: 300)
            }
        }
        .frame(height: 400)
    }
}

#Preview {
    PhysicsTabView()
        .environmentObject(PlaygroundState())
}
