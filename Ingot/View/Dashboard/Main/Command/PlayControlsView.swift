// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PlayButtonsView: View {
    let sceneManager: SKPScene
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack(spacing: 50) {
                Button("Run Actions") {
                    sceneManager.startActions()
                }

                Button("Run Actions on Selected") {
                    sceneManager.startActionsOnSelected()
                }

                Button("Stop Actions") {
                    sceneManager.stopActions()
                }
            }
        }
        .padding()
    }
}

#Preview {
    PlayButtonsView(sceneManager: SKPScene(size: .zero))
}
