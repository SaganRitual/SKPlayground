// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsBodyView: View {
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var physicsBodyState: PhysicsBodyState

    let widthSlider = 500.0

    func makeScalarView(_ value: CGFloat) -> some View {
        Text(String(format: "%.2f", value))
    }

    var body: some View {
        if gameController.entitySelectionState.selectionState == .one &&
            gameController.getSelected().first! is Gremlin
        {
            bodySelect
        } else {
            bodyNoSelect
        }
    }

    var bodyNoSelect: some View {
        Text("No Gremlin is selected")
    }

    var bodySelect: some View {
        VStack {
            VStack(alignment: .center, spacing: 0) {
                HStack(spacing: 50) {
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
            }

            VStack(alignment: .leading, spacing: 0) {
                BasicScalarSlider(
                    scalar: $physicsBodyState.friction,
                    scalarView: Text(String(format: "%.2f", physicsBodyState.friction)),
                    title: Text("Friction"),
                    minLabel: "-2", maxLabel: "25", range: -2...25, widthSlider: widthSlider
                )
                .padding(.top)
                .onChange(of: physicsBodyState.friction) {
                    gameController.setFrictionOnSelected(physicsBodyState.friction)
                }

                BasicScalarSlider(
                    scalar: $physicsBodyState.mass,
                    scalarView: Text(String(format: "%.2f", physicsBodyState.mass)),
                    title: Text("Mass"),
                    minLabel: "0", maxLabel: "25", range: 0...25, widthSlider: widthSlider
                )
                .padding(.top)
                .onChange(of: physicsBodyState.mass) {
                    gameController.setMassOnSelected(physicsBodyState.mass)
                }

                BasicScalarSlider(
                    scalar: $physicsBodyState.restitution,
                    scalarView: Text(String(format: "%.2f", physicsBodyState.restitution)),
                    title: Text("Restitution"),
                    minLabel: "-2", maxLabel: "25", range: -2...25, widthSlider: widthSlider
                )
                .padding(.top)
                .onChange(of: physicsBodyState.restitution) {
                    gameController.setRestitutionOnSelected(physicsBodyState.restitution)
                }

                Text("Damping")
                    .underline()
                    .padding(.top, 30)

                BasicScalarSlider(
                    scalar: $physicsBodyState.angularDamping,
                    scalarView: Text(String(format: "%.2f", physicsBodyState.angularDamping)),
                    title: Text("Angular"),
                    minLabel: "-2", maxLabel: "25", range: -2...25, widthSlider: widthSlider
                )
                .padding(.top)
                .onChange(of: physicsBodyState.angularDamping) {
                    gameController.setAngularDampingOnSelected(physicsBodyState.angularDamping)
                }

                BasicScalarSlider(
                    scalar: $physicsBodyState.linearDamping,
                    scalarView: Text(String(format: "%.2f", physicsBodyState.linearDamping)),
                    title: Text("Linear"),
                    minLabel: "-2", maxLabel: "25", range: -2...25, widthSlider: widthSlider
                )
                .padding(.top)
                .padding(.bottom, 30)
                .onChange(of: physicsBodyState.linearDamping) {
                    gameController.setLinearDampingOnSelected(physicsBodyState.linearDamping)
                }

                PhysicsBodyCategoriesView()
            }
            .frame(width: 700, height: 350)
            .onAppear {
                gameController.reloadEntityViews()
            }
        }
    }
}

#Preview {
    PhysicsBodyView()
        .environmentObject(GameController())
        .environmentObject(PhysicsBodyState(preview: true))
        .environmentObject(PhysicsMaskCategories())
}
