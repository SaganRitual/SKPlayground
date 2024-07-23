// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PlayButtonsView: View {
    let sceneManager: SKPScene
    @ObservedObject var physicsWorldRelay: PhysicsWorldRelay

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
                Spacer()

                Button("Run Actions") {
                    sceneManager.startActions()
                }

                Spacer()

                Button("Run Actions on Selected") {
                    sceneManager.startActionsOnSelected()
                }

                Spacer()

                Button("Stop Actions") {
                    sceneManager.stopActions()
                }

                Spacer()
            }

            HStack {
                Spacer()

                Button("Run Physics") {
                    sceneManager.playPhysics()
                }
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
                .disabled(physicsWorldRelay.speed == 0)

                Spacer()
            }
        }
        .padding([.horizontal, .top])
    }
}
