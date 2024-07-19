// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PlayConfigurator: View {
    @ObservedObject var commandRelay: CommandRelay
    @ObservedObject var workflowRelay: WorkflowRelay

    @State private var isPlaying = false
    @State private var applyToActions = false
    @State private var applyToPhysics = false

    let sceneManager: SKPScene

    func updateActionsState() {
        let goActions = isPlaying && applyToActions
        if goActions { sceneManager.startActions() }
        else { sceneManager.stopActions() }
    }

    func updatePhysicsState() {
        let goPhysics = isPlaying && applyToPhysics
        if goPhysics { sceneManager.startPhysics() }
        else { sceneManager.stopPhysics() }
    }

    var body: some View {
        VStack {
            PlayButtonsView(sceneManager: sceneManager)
            PlaySlidersGrid(commandRelay: commandRelay)
        }
    }
}

#Preview {
    PlayConfigurator(commandRelay: CommandRelay(), workflowRelay: WorkflowRelay(), sceneManager: SKPScene(size: .zero))
}
