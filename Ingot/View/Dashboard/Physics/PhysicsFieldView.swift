// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
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
    @EnvironmentObject var commandSelection: CommandSelection
    @EnvironmentObject var entitySelectionState: EntitySelectionState
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var physicsFieldState: PhysicsFieldState
    @EnvironmentObject var shapeLab: ShapeLab

    @State private var setGravity = false
    @State private var velocityPair = ABPair(a: 0, b: 0)

    var body: some View {
        if gameController.entitySelectionState.selectionState == .one &&
            gameController.getSelected().first! is Field
        {
            bodySelect
        } else {
            bodyNoSelect
        }
    }

    var bodyNoSelect: some View {
        Text("No Field is selected")
    }

    var bodySelect: some View {
        VStack(spacing: 0) {
            Text(physicsFieldState.fieldType.rawValue)
                .underline()
                .padding(.top, 0)
                .padding(.bottom)

            HStack {
                Spacer()

                Toggle(isOn: $physicsFieldState.enabled) {
                    Text("Enabled")
                }
                .toggleStyle(.checkbox)
                .onChange(of: physicsFieldState.enabled) {
                    guard gameController.entitySelectionState.selectionState == .one else { return }
                    guard let fieldEntity = gameController.getSelected().first as? Field else { return }

                    let fieldNode_ = fieldEntity.face.rootSceneNode.children.first(where: { $0 is SKFieldNode })
                    let fieldNode = Utility.forceCast(fieldNode_, to: SKFieldNode.self)

                    fieldNode.isEnabled = physicsFieldState.enabled
                }

                Spacer()

                Toggle(isOn: $physicsFieldState.exclusive) {
                    Text("Exclusive")
                }
                .toggleStyle(.checkbox)
                .onChange(of: physicsFieldState.exclusive) {
                    guard gameController.entitySelectionState.selectionState == .one else { return }
                    guard let fieldEntity = gameController.getSelected().first as? Field else { return }

                    let fieldNode_ = fieldEntity.face.rootSceneNode.children.first(where: { $0 is SKFieldNode })
                    let fieldNode = Utility.forceCast(fieldNode_, to: SKFieldNode.self)

                    fieldNode.isExclusive = physicsFieldState.exclusive
                }

                Spacer()
            }

            VStack(spacing: 0) {
                if setGravity {
                    Button("Other Field Settings") {
                        setGravity = false
                    }

                    if physicsFieldState.fieldType == .velocity {
                        Slider2DView(
                            output: $velocityPair,
                            size: CGSize(width: 300, height: 300),
                            snapTolerance: 5,
                            title: Text("Field Velocity"),
                            virtualSize: CGSize(width: 50, height: 50)
                        )
                        .padding(.trailing)
                        .onChange(of: velocityPair) {
                            physicsFieldState.direction = CGVector(velocityPair)

                            guard gameController.entitySelectionState.selectionState == .one else { return }
                            guard let fieldEntity = gameController.getSelected().first as? Field else { return }

                            let fieldNode_ = fieldEntity.face.rootSceneNode.children.first(where: { $0 is SKFieldNode })
                            let fieldNode = Utility.forceCast(fieldNode_, to: SKFieldNode.self)

                            fieldNode.direction = vector_float3(
                                x: Float(velocityPair.a), y: Float(velocityPair.b), z: 0
                            )
                        }
                    }

                    else if physicsFieldState.fieldType == .linearGravity {
                        Slider2DView(
                            output: $velocityPair,
                            size: CGSize(width: 300, height: 300),
                            snapTolerance: 5,
                            title: Text("Field Gravity"),
                            virtualSize: CGSize(width: 50, height: 50)
                        )
                        .padding(.trailing)
                        .onChange(of: velocityPair) {
                            physicsFieldState.direction = CGVector(velocityPair)

                            guard gameController.entitySelectionState.selectionState == .one else { return }
                            guard let fieldEntity = gameController.getSelected().first as? Field else { return }

                            let fieldNode_ = fieldEntity.face.rootSceneNode.children.first(where: { $0 is SKFieldNode })
                            let fieldNode = Utility.forceCast(fieldNode_, to: SKFieldNode.self)

                            fieldNode.direction = vector_float3(x: Float(velocityPair.a), y: Float(velocityPair.b), z: 0)
                        }
                    }
                } else {

                    VStack {
                        if physicsFieldState.fieldType == .linearGravity {
                            Button("Set Field Gravity") {
                                setGravity = true
                            }
                        } else if physicsFieldState.fieldType == .velocity {
                            Button("Set Field Velocity") {
                                setGravity = true
                            }
                        }

                        PhysicsFieldSlidersView(setGravity: $setGravity)
                    }
                }
            }
            .frame(height: 300)
        }
        .frame(width: 700, height: 350)
    }
}

#Preview {
    PhysicsFieldView()
        .environmentObject(PhysicsFieldState())
        .environmentObject(PhysicsMaskCategories())
}
