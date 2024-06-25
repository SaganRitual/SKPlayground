// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

enum PlaceablePhysics: String, RawRepresentable, CaseIterable, Identifiable {
    var id: String { self.rawValue }

    case edge = "Edge", field = "Field", joint = "Joint"
}

enum PhysicsFieldType: String, CaseIterable, Identifiable, RawRepresentable {
    var id: String { self.rawValue }

    case drag = "Drag", electric = "Electric", linearGravity = "Linear Gravity"
    case magnetic = "Magnetic", noise = "Noise", radialGravity = "Radial Gravity"
    case spring = "Spring", turbulence = "Turbulence", velocity = "Velocity"
    case vortex = "Vortex"
}

struct PhysicsFieldView: View {
    @EnvironmentObject var playgroundState: PlaygroundState

    @State private var enableRegion = false
    @State private var selectedCategoryIndices = Set<Int>()

    func makeScalarView(_ value: CGFloat) -> some View {
        Text(String(format: "%.1f", value))
    }

    var regionToggle: some View {
        Toggle(isOn: $enableRegion) {
            Text("Region")
        }
        .toggleStyle(.checkbox)
    }

    var body: some View {
        VStack {
            HStack {
                Toggle(isOn: $playgroundState.physicsField.enabled) {
                    Text("Enabled")
                }
                .toggleStyle(.checkbox)

                Toggle(isOn: $playgroundState.physicsField.exclusive) {
                    Text("Exclusive")
                }
                .toggleStyle(.checkbox)
            }

            VStack {
                HStack {
                    BasicScalarSlider(
                        scalar: $playgroundState.physicsField.falloff,
                        scalarView: Text(String(format: "%.1f", playgroundState.physicsField.falloff)),
                        title: Text("Falloff"),
                        minLabel: "0", maxLabel: "100", range: 0...100
                    )
                    BasicScalarSlider(
                        scalar: $playgroundState.physicsField.minimumRadius,
                        scalarView: Text(String(format: "%.1f", playgroundState.physicsField.minimumRadius)),
                        title: VStack(alignment: .leading) { Text("Minimum"); Text("Radius") },
                        minLabel: "0", maxLabel: "100", range: 0...100
                    )
                }
                HStack {
                    BasicScalarSlider(
                        scalar: $playgroundState.physicsField.smoothness,
                        scalarView: Text(String(format: "%.1f", playgroundState.physicsField.smoothness)),
                        title: Text("Smooth"),
                        minLabel: "0", maxLabel: "100", range: 0...100
                    )
                    BasicScalarSlider(
                        scalar: $playgroundState.physicsField.strength,
                        scalarView: Text(String(format: "%.1f", playgroundState.physicsField.strength)),
                        title: Text("Strength"),
                        minLabel: "0", maxLabel: "100", range: 0...100
                    )
                }
            }

            HStack {
                Slider2DView(
                    output: $playgroundState.physicsField.region,
                    size: CGSize(width: 100, height: 100),
                    snapTolerance: 5,
                    title: regionToggle,
                    virtualSize: CGSize(width: 20, height: 20)
                )
                .padding(.trailing)

                if playgroundState.selectedPhysicsField.fieldType == .velocity {
                    Slider2DView(
                        output: $playgroundState.physicsField.direction,
                        size: CGSize(width: 100, height: 100),
                        snapTolerance: 5,
                        title: Text("Direction"),
                        virtualSize: CGSize(width: 20, height: 20)
                    )
                    .padding(.trailing)
                }

                VStack {
                    if playgroundState.selectedPhysicsField.fieldType == .noise ||
                        playgroundState.selectedPhysicsField.fieldType == .turbulence {
                        BasicScalarSlider(
                            scalar: $playgroundState.physicsField.animationSpeed,
                            scalarView: Text(String(format: "%.1f", playgroundState.physicsField.animationSpeed)),
                            title: VStack(alignment: .leading) { Text("Animation"); Text("Speed") },
                            minLabel: "0", maxLabel: "100", range: 0...100
                        )
                        .padding([.leading, .bottom])
                    }

                    CheckboxPicker(
                        selectedIndices: $selectedCategoryIndices,
                        label: Text("Set Categories"),
                        options: playgroundState.physicsCategories.names
                    )
                    .padding(.leading)
                }
            }
            .padding([.horizontal])
        }
    }
}

#Preview {
    PhysicsFieldView()
        .environmentObject(PlaygroundState())
}
