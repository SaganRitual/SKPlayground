// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsBodyView: View {
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var physicsBodyState: PhysicsBodyState

    func makeScalarView(_ value: CGFloat) -> some View {
        Text(String(format: "%.2f", value))
    }

    var verb: String {
        physicsBodyState.hasPhysicsBody ? "Remove" : "Attach"
    }

    var body: some View {
        VStack {
            HStack(spacing: 30) {
                Button("\(verb) Physics Body") {
                    if physicsBodyState.hasPhysicsBody {
                        gameController.removePhysicsBody()
                        physicsBodyState.hasPhysicsBody = false
                    } else {
                        gameController.attachPhysicsBody()
                        physicsBodyState.hasPhysicsBody = true
                    }
                }

                Toggle(isOn: $physicsBodyState.dynamism) {
                    Text("Apply Physics")
                }
                .toggleStyle(.checkbox)
                .onChange(of: physicsBodyState.dynamism) {
                    gameController.enablePhysicsOnSelected(physicsBodyState.dynamism)
                }

                Toggle(isOn: $physicsBodyState.gravitism) {
                    Text("Apply Gravity")
                }
                .toggleStyle(.checkbox)
                .onChange(of: physicsBodyState.gravitism) {
                    gameController.enableGravityOnSelected(physicsBodyState.gravitism)
                }

                Toggle(isOn: $physicsBodyState.rotatism) {
                    Text("Allow Rotation")
                }
                .toggleStyle(.checkbox)
                .onChange(of: physicsBodyState.rotatism) {
                    gameController.enableRotationOnSelected(physicsBodyState.rotatism)
                }
            }
            .padding()

            HStack(alignment: .top) {
                VStack {
//                    BasicScalarSlider(
//                        scalar: $physicsBodyState.density,
//                        scalarView: Text(String(format: "%.1f", physicsBodyState.density)),
//                        title: Text("Density"),
//                        minLabel: "0", maxLabel: "10", range: 0...10
//                    )
//                    .onChange(of: physicsBodyState.density) {
//                        gameController.setDensityOnSelected(physicsBodyState.density)
//                    }

                    BasicScalarSlider(
                        scalar: $physicsBodyState.friction,
                        scalarView: Text(String(format: "%.1f", physicsBodyState.friction)),
                        title: Text("Friction"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )
                    .onChange(of: physicsBodyState.friction) {
                        gameController.setFrictionOnSelected(physicsBodyState.friction)
                    }
                }

                VStack {
                    BasicScalarSlider(
                        scalar: $physicsBodyState.mass,
                        scalarView: Text(String(format: "%.1f", physicsBodyState.mass)),
                        title: Text("Mass"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )
                    .onChange(of: physicsBodyState.mass) {
                        gameController.setMassOnSelected(physicsBodyState.mass)
                    }

                    BasicScalarSlider(
                        scalar: $physicsBodyState.restitution,
                        scalarView: Text(String(format: "%.1f", physicsBodyState.restitution)),
                        title: Text("Restitution"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )
                    .onChange(of: physicsBodyState.restitution) {
                        gameController.setRestitutionOnSelected(physicsBodyState.restitution)
                    }
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
                    .onChange(of: physicsBodyState.angularDamping) {
                        gameController.setAngularDampingOnSelected(physicsBodyState.angularDamping)
                    }

                    BasicScalarSlider(
                        scalar: $physicsBodyState.linearDamping,
                        scalarView: Text(String(format: "%.1f", physicsBodyState.linearDamping)),
                        title: Text("Linear"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )
                    .onChange(of: physicsBodyState.linearDamping) {
                        gameController.setLinearDampingOnSelected(physicsBodyState.linearDamping)
                    }
                }
            }
        }
        .frame(width: 700, height: 400)
        .onAppear() {
            gameController.loadPhysicsBodyFromSelected()
        }
//        .onAppear() {
//            physicsBodyState.dynamism = gameController.isPhysicsEnabledOnSelected()
//            physicsBodyState.gravitism = gameController.isGravityEnabledOnSelected()
//            physicsBodyState.rotatism = gameController.isRotationEnabledOnSelected()
//
//            physicsBodyState.angularDamping = gameController.getAngularDampingOnSelected()
//            physicsBodyState.density = gameController.getDensityOnSelected()
//            physicsBodyState.friction = gameController.getFrictionOnSelected()
//            physicsBodyState.mass = gameController.getMassOnSelected()
//            physicsBodyState.restitution = gameController.getRestitutionOnSelected()
//            physicsBodyState.linearDamping = gameController.getLinearDampingOnSelected()
//        }
    }
}

#Preview {
    PhysicsBodyView()
        .environmentObject(GameController())
        .environmentObject(PhysicsBodyState(preview: true))
        .environmentObject(PhysicsMaskCategories())
}
