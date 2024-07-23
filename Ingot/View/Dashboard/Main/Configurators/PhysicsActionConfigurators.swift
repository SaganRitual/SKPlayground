// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsActionConfigurators: View {
    enum PhysicsActionType: String, CaseIterable, Identifiable {
        var id: Self { self }

        case force = "Force", torque = "Torque", impulse = "Impulse", angularImpulse = "Θ-impulse"
    }

    @ObservedObject var actionRelay: ActionRelay
    @ObservedObject var gameController: GameController

    @State private var selectedType = PhysicsActionType.force

    var body: some View {
        if gameController.singleSelected() is Gremlin {
            VStack {
                Picker(
                    selection: $selectedType,
                    content: {
                        ForEach(PhysicsActionType.allCases) { type in
                            Text(type.rawValue.capitalized).tag(type)
                        }
                    },
                    label: {
                        Button("Create Action") {
                            let actionToken: ActionToken

                            switch selectedType {
                            case .force:   actionToken = ForceActionToken()
                            case .torque:  actionToken = TorqueActionToken()
                            case .impulse: actionToken = ImpulseActionToken()
                            case .angularImpulse: actionToken = AngularImpulseActionToken()
                            }

                            gameController.addActionToSelected(actionToken)
                        }
                    }
                )
                .pickerStyle(.menu)
                .padding()

                if gameController.selectedAction != nil {
                    PhysicsActionSlidersGrid(
                        actionRelay: gameController.actionRelay,
                        selectedAction: Binding(
                            get: { gameController.selectedAction },
                            set: { gameController.selectedAction = $0 }
                        )
                    )

                    Spacer()

                    ActionTokensScrollView(
                        actionRelay: gameController.actionRelay, gameController: gameController
                    )
                        .padding(.bottom)
                } else {
                    Text("This Gremlin has no actions")
                }
            }
        } else {
            Text("No Gremlins selected, or multiple Gremlins selected")
        }
    }
}
