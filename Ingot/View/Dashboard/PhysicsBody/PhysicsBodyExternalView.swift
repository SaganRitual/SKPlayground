// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsBodyExternalView: View {
    @EnvironmentObject var playgroundState: PlaygroundState

    func makeScalarView(_ value: CGFloat) -> some View {
        Text(String(format: "%.2f", value))
    }

    var body: some View {
        HStack {
            VStack {
                BasicScalarSlider(
                    scalar: $playgroundState.physicsBodyHaver.area,
                    scalarView: Text(String(format: "%.1f", playgroundState.physicsBodyHaver.area)),
                    title: Text("Area"),
                    minLabel: "0", maxLabel: "10", range: 0...10
                )

                BasicScalarSlider(
                    scalar: $playgroundState.physicsBodyHaver.friction,
                    scalarView: Text(String(format: "%.1f", playgroundState.physicsBodyHaver.friction)),
                    title: Text("Friction"),
                    minLabel: "0", maxLabel: "10", range: 0...10
                )
            }

            VStack {
                HStack {
                    Text("Restitution")
                    Text(String(format: "%.1f", playgroundState.physicsBodyHaver.restitution))
                }

                BasicScalarSlider(
                    scalar: $playgroundState.physicsBodyHaver.restitution,
                    scalarView: EmptyView(),
                    title: EmptyView(),
                    minLabel: "0", maxLabel: "10", range: 0...10
                )
            }
        }
    }
}

#Preview {
    PhysicsBodyExternalView()
        .environmentObject(PlaygroundState())
}
