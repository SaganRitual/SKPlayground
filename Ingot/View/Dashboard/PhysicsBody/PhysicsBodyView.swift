// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsBodyView: View {
    @EnvironmentObject var physicsBodyState: PhysicsBodyState

    func makeScalarView(_ value: CGFloat) -> some View {
        Text(String(format: "%.2f", value))
    }

    var body: some View {
        VStack {
            HStack(spacing: 30) {
                Toggle(isOn: $physicsBodyState.dynamism) {
                    Text("Apply Physics")
                }
                .toggleStyle(.checkbox)

                Toggle(isOn: $physicsBodyState.gravitism) {
                    Text("Apply Gravity")
                }
                .toggleStyle(.checkbox)

                Toggle(isOn: $physicsBodyState.rotatism) {
                    Text("Allow Rotation")
                }
                .toggleStyle(.checkbox)
            }
            .padding()

            HStack(alignment: .top) {
                VStack {
                    BasicScalarSlider(
                        scalar: $physicsBodyState.area,
                        scalarView: Text(String(format: "%.1f", physicsBodyState.area)),
                        title: Text("Area"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )

                    BasicScalarSlider(
                        scalar: $physicsBodyState.density,
                        scalarView: Text(String(format: "%.1f", physicsBodyState.density)),
                        title: Text("Density"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )

                    BasicScalarSlider(
                        scalar: $physicsBodyState.friction,
                        scalarView: Text(String(format: "%.1f", physicsBodyState.friction)),
                        title: Text("Friction"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )
                }

                VStack {
                    BasicScalarSlider(
                        scalar: $physicsBodyState.mass,
                        scalarView: Text(String(format: "%.1f", physicsBodyState.mass)),
                        title: Text("Mass"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )

                    BasicScalarSlider(
                        scalar: $physicsBodyState.restitution,
                        scalarView: Text(String(format: "%.1f", physicsBodyState.restitution)),
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
                        scalar: $physicsBodyState.angularDamping,
                        scalarView: Text(String(format: "%.1f", physicsBodyState.angularDamping)),
                        title: Text("Angular"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )

                    BasicScalarSlider(
                        scalar: $physicsBodyState.linearDamping,
                        scalarView: Text(String(format: "%.1f", physicsBodyState.linearDamping)),
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
        .environmentObject(PhysicsBodyState())
}
