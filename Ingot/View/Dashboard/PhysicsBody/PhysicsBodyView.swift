// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsBodyView: View {
    @EnvironmentObject var playgroundState: PlaygroundState

    func makeScalarView(_ value: CGFloat) -> some View {
        Text(String(format: "%.2f", value))
    }

    var body: some View {
        VStack {
            HStack(spacing: 30) {
                Toggle(isOn: $playgroundState.physicsBodyHaver.dynamism) {
                    Text("Apply Physics")
                }
                .toggleStyle(.checkbox)

                Toggle(isOn: $playgroundState.physicsBodyHaver.gravitism) {
                    Text("Apply Gravity")
                }
                .toggleStyle(.checkbox)

                Toggle(isOn: $playgroundState.physicsBodyHaver.rotatism) {
                    Text("Allow Rotation")
                }
                .toggleStyle(.checkbox)
            }
            .padding()

            HStack(alignment: .top) {
                VStack {
                    BasicScalarSlider(
                        scalar: $playgroundState.physicsBodyHaver.area,
                        scalarView: Text(String(format: "%.1f", playgroundState.physicsBodyHaver.area)),
                        title: Text("Area"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )

                    BasicScalarSlider(
                        scalar: $playgroundState.physicsBodyHaver.density,
                        scalarView: Text(String(format: "%.1f", playgroundState.physicsBodyHaver.density)),
                        title: Text("Density"),
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
                    BasicScalarSlider(
                        scalar: $playgroundState.physicsBodyHaver.mass,
                        scalarView: Text(String(format: "%.1f", playgroundState.physicsBodyHaver.mass)),
                        title: Text("Mass"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )

                    BasicScalarSlider(
                        scalar: $playgroundState.physicsBodyHaver.restitution,
                        scalarView: Text(String(format: "%.1f", playgroundState.physicsBodyHaver.restitution)),
                        title: Text("Restitution"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )
                }
            }

            HStack(alignment: .bottom) {
                PhysicsBodyCategoriesView()

                VStack {
                    Text("Damping")
                        .underline()

                    BasicScalarSlider(
                        scalar: $playgroundState.physicsBodyHaver.angularDamping,
                        scalarView: Text(String(format: "%.1f", playgroundState.physicsBodyHaver.angularDamping)),
                        title: Text("Angular"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )

                    BasicScalarSlider(
                        scalar: $playgroundState.physicsBodyHaver.linearDamping,
                        scalarView: Text(String(format: "%.1f", playgroundState.physicsBodyHaver.linearDamping)),
                        title: Text("Linear"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )
                }
            }
        }
        .frame(width: 700, height: 400)
    }
}

#Preview {
    PhysicsBodyView()
        .environmentObject(PlaygroundState())
}
