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
    @EnvironmentObject var physicsFieldState: PhysicsFieldState
    @EnvironmentObject var physicsMaskCategories: PhysicsMaskCategories

    @State private var enableRegion = false
    @State private var selectedCategoryIndices = Set<Int>()
    @State private var regionPair = ABPair(a: 0, b: 0)
    @State private var velocityPair = ABPair(a: 0, b: 0)

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
                Toggle(isOn: $physicsFieldState.enabled) {
                    Text("Enabled")
                }
                .toggleStyle(.checkbox)

                Toggle(isOn: $physicsFieldState.exclusive) {
                    Text("Exclusive")
                }
                .toggleStyle(.checkbox)
            }

            VStack {
                HStack {
                    BasicScalarSlider(
                        scalar: $physicsFieldState.falloff,
                        scalarView: Text(String(format: "%.1f", physicsFieldState.falloff)),
                        title: Text("Falloff"),
                        minLabel: "0", maxLabel: "100", range: 0...100
                    )
                    BasicScalarSlider(
                        scalar: $physicsFieldState.minimumRadius,
                        scalarView: Text(String(format: "%.1f", physicsFieldState.minimumRadius)),
                        title: VStack(alignment: .leading) { Text("Minimum"); Text("Radius") },
                        minLabel: "0", maxLabel: "100", range: 0...100
                    )
                }
                HStack {
                    BasicScalarSlider(
                        scalar: $physicsFieldState.smoothness,
                        scalarView: Text(String(format: "%.1f", physicsFieldState.smoothness)),
                        title: Text("Smooth"),
                        minLabel: "0", maxLabel: "100", range: 0...100
                    )
                    BasicScalarSlider(
                        scalar: $physicsFieldState.strength,
                        scalarView: Text(String(format: "%.1f", physicsFieldState.strength)),
                        title: Text("Strength"),
                        minLabel: "0", maxLabel: "100", range: 0...100
                    )
                }
            }

            HStack {
                Slider2DView(
                    output: $regionPair,
                    size: CGSize(width: 100, height: 100),
                    snapTolerance: 5,
                    title: regionToggle,
                    virtualSize: CGSize(width: 20, height: 20)
                )
                .padding(.trailing)
                .onChange(of: regionPair) {
                    physicsFieldState.region = CGSize(regionPair)
                }

                if physicsFieldState.fieldType == .velocity {
                    Slider2DView(
                        output: $velocityPair,
                        size: CGSize(width: 100, height: 100),
                        snapTolerance: 5,
                        title: Text("Direction"),
                        virtualSize: CGSize(width: 20, height: 20)
                    )
                    .padding(.trailing)
                    .onChange(of: velocityPair) {
                        physicsFieldState.direction = CGVector(velocityPair)
                    }
                }

                VStack {
                    if physicsFieldState.fieldType == .noise ||
                        physicsFieldState.fieldType == .turbulence {
                        BasicScalarSlider(
                            scalar: $physicsFieldState.animationSpeed,
                            scalarView: Text(String(format: "%.1f", physicsFieldState.animationSpeed)),
                            title: VStack(alignment: .leading) {
                                Text("Animation").font(.system(size: 10))
                                Text("Speed").font(.system(size: 10))
                            },
                            minLabel: "0", maxLabel: "100", range: 0...100
                        )
                        .padding([.leading, .bottom])
                    }

                    CheckboxPicker(
                        selectedIndices: $selectedCategoryIndices,
                        label: Text("Set Categories"),
                        options: physicsMaskCategories.names
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
        .environmentObject(PhysicsFieldState())
        .environmentObject(PhysicsMaskCategories())
}
