// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PlayButtonsView: View {
    let sceneManager: SKPScene
    @ObservedObject var gameController: GameController
    @ObservedObject var physicsWorldRelay: PhysicsWorldRelay

    @State private var actionSet = GameController.ActionSet.all

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Picker("Action Set", selection: $actionSet) {
                ForEach(GameController.ActionSet.allCases) { set in
                    Text(set.rawValue.capitalized).tag(set)
                }
            }
            .pickerStyle(.segmented)

            HStack {
                Button("Run \(actionSet.rawValue.capitalized) Actions") {
                    gameController.startActions(actionSet)
                }
                .padding(.leading)

                Spacer()

                Button("Run \(actionSet.rawValue.capitalized) Actions on Selected") {
                    gameController.startActionsOnSelected(actionSet)
                }

                Spacer()

                Button("Stop Actions") {
                    sceneManager.stopActions()
                }
                .padding(.trailing)
            }

            HStack {
                Button("Run Physics") {
                    sceneManager.playPhysics()
                }
                .padding(.leading)
                .disabled(physicsWorldRelay.speed != 0)

                Spacer()

                Button("Retrieve Escaped Gremlins") {
                    sceneManager.pausePhysics()
                    sceneManager.retrieveEscapedGremlins()
                }

                Spacer()

                Button("Stop Physics") {
                    sceneManager.pausePhysics()
                }
                .padding(.trailing)
                .disabled(physicsWorldRelay.speed == 0)
            }
        }
        .padding([.horizontal, .top])
    }
}
