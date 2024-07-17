// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct CommandView: View {
    @ObservedObject var commandRelay: CommandRelay
    @ObservedObject var workflowRelay: WorkflowRelay

    let sceneManager: SKPScene
    
    var body: some View {
        VStack {
            Text("Command")
                .underline()
                .padding(.bottom)

            ClickToPlaceView(workflowRelay: workflowRelay)
            PlayConfigurator(commandRelay: commandRelay, workflowRelay: workflowRelay, sceneManager: sceneManager)
        }
    }
}

#Preview {
    CommandView(commandRelay: CommandRelay(), workflowRelay: WorkflowRelay(), sceneManager: SKPScene(size: .zero))
}
