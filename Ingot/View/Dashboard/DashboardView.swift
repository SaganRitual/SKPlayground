// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack {
            PlaygroundStatusView()
                .frame(height: 100)
                .padding()
                .background(Color(NSColor.secondarySystemFill))
                .padding(2)

            CommandView()
                .frame(height: 200)
                .padding()
                .background(Color(NSColor.secondarySystemFill))
                .padding(2)

            ConfigurationTabView()
                .padding()
                .background(Color(NSColor.secondarySystemFill))
                .padding(2)
        }
        .monospaced()
    }
}

#Preview {
    DashboardView()
        .environmentObject(CommandSelection())
        .environmentObject(EntitySelectionState())
        .environmentObject(GameController())
        .environmentObject(PhysicsWorldState())
        .environmentObject(PhysicsMaskCategories())
        .environmentObject(PlaygroundState())
}
