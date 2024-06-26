// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct GameControllerTestView: View {
    @EnvironmentObject var gameController: GameController

    var body: some View {
        VStack {
            Button("Select Gremlin 1") {
                
            }
        }
    }
}

#Preview {
    GameControllerTestView()
}
