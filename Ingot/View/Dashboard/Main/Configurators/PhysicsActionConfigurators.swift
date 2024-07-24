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

    private func newAction(_ actionType: PhysicsActionType, randomValues: Bool = false) {
        let actionToken: ActionToken

        switch actionType {
        case .force:   actionToken = ForceActionToken(randomValues: randomValues)
        case .torque:  actionToken = TorqueActionToken(randomValues: randomValues)
        case .impulse: actionToken = ImpulseActionToken(randomValues: randomValues)
        case .angularImpulse: actionToken = AngularImpulseActionToken(randomValues: randomValues)
        }

        gameController.addActionToSelected(actionToken)
    }

    var body: some View {
        if gameController.singleSelected() is Gremlin {
            VStack {
                HStack {
                    Picker(
                        selection: $selectedType,
                        content: {
                            ForEach(PhysicsActionType.allCases) { type in
                                Text(type.rawValue.capitalized).tag(type)
                            }
                        },
                        label: {
                            Button("Create Action") {
                                newAction(selectedType)
                            }
                        }
                    )
                    .pickerStyle(.menu)
                    .padding()

                    Button("Create Random") {
                        let randomType = Utility.forceUnwrap(PhysicsActionType.allCases.randomElement())
                        newAction(randomType, randomValues: true)
                    }
                }

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
