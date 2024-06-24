// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsEntityView: View {
    @State private var area: CGFloat = 0
    @State private var density: CGFloat = 0
    @State private var friction: CGFloat = 0
    @State private var mass: CGFloat = 0
    @State private var restitution: CGFloat = 0
    @State private var angularDamping: CGFloat = 0
    @State private var linearDamping: CGFloat = 0

    func makeScalarView(_ value: CGFloat) -> some View {
        Text(String(format: "%.2f", value))
    }

    var body: some View {
        HStack {
            VStack {
                BasicScalarSlider(
                    scalar: $area,
                    scalarView: Text(String(format: "%.2f", area)),
                    title: Text("Area"),
                    minLabel: "0", maxLabel: "10", range: 0...10
                )

                BasicScalarSlider(
                    scalar: $density,
                    scalarView: Text(String(format: "%.2f", density)),
                    title: Text("Density"),
                    minLabel: "0", maxLabel: "10", range: 0...10
                )

                BasicScalarSlider(
                    scalar: $friction,
                    scalarView: Text(String(format: "%.2f", friction)),
                    title: Text("Friction"),
                    minLabel: "0", maxLabel: "10", range: 0...10
                )

                BasicScalarSlider(
                    scalar: $mass,
                    scalarView: Text(String(format: "%.2f", mass)),
                    title: Text("Mass"),
                    minLabel: "0", maxLabel: "10", range: 0...10
                )
            }

            VStack {
                BasicScalarSlider(
                    scalar: $restitution,
                    scalarView: Text(String(format: "%.2f", restitution)),
                    title: Text("Restitution"),
                    minLabel: "0", maxLabel: "10", range: 0...10
                )

                Text("Damping") // Place the Damping label above both damping sliders
                    .font(.system(size: 12))
                    .underline()
                    .padding(.top, 35)

                BasicScalarSlider(
                    scalar: $angularDamping,
                    scalarView: Text(String(format: "%.2f", angularDamping)),
                    title: Text("Angular"),
                    minLabel: "0", maxLabel: "10", range: 0...10
                )

                BasicScalarSlider(
                    scalar: $linearDamping,
                    scalarView: Text(String(format: "%.2f", linearDamping)),
                    title: Text("Linear"),
                    minLabel: "0", maxLabel: "10", range: 0...10
                )
            }
        }
    }
}

#Preview {
    PhysicsEntityView()
}
