// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsBodyTabView: View {
    var body: some View {
        TabView {
            PhysicsBodyInertialView()
                .padding()
                .tabItem {
                    Label("Inertial", systemImage: "atom")
                }

            PhysicsBodyExternalView()
                .padding()
                .tabItem {
                    Label("External", systemImage: "atom")
                }

            PhysicsBodyTogglesView()
                .padding()
                .tabItem {
                    Label("Toggles", systemImage: "atom")
                }
        }
        .frame(height: 200)
        .padding(.top)
    }
}

#Preview {
    PhysicsBodyTabView()
        .environmentObject(PlaygroundState())
}
