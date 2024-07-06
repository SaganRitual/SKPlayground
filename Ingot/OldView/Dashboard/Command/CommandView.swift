// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct CommandView: View {
    var body: some View {
        VStack {
            Text("Command")
                .underline()
                .padding(.bottom)

            ClickToPlaceView()
            PlayControlsView()
        }
    }
}

#Preview {
    CommandView()
        .environmentObject(CommandSelection())
}
