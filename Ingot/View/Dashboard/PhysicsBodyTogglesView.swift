// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsBodyTogglesView: View {
    @EnvironmentObject var playgroundState: PlaygroundState

    var body: some View {
        HStack(spacing: 75) {
            Toggle(isOn: $playgroundState.physicsBodyHaver.dynamism) {
                Text("Physics")
            }
            .toggleStyle(.checkbox)

            Toggle(isOn: $playgroundState.physicsBodyHaver.gravitism) {
                Text("Gravity")
            }
            .toggleStyle(.checkbox)

            Toggle(isOn: $playgroundState.physicsBodyHaver.rotatism) {
                Text("Rotation")
            }
            .toggleStyle(.checkbox)
        }
        .padding()
    }
}

#Preview {
    PhysicsBodyTogglesView()
        .environmentObject(PlaygroundState())
}
