// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsTabView: View {
    var body: some View {
        VStack {
            Text("Physics")
                .underline()
                .padding(.vertical)

            TabView {
                PhysicsBodyTabView()
                    .padding()
                    .tabItem {
                        Label("Body", systemImage: "atom")
                    }

                PhysicsFieldView()
                    .padding()
                    .tabItem {
                        Label("Field", systemImage: "atom")
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
