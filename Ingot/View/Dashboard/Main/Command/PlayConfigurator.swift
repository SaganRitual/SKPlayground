// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PlayConfigurator: View {
    @ObservedObject var commandRelay: CommandRelay
    @ObservedObject var physicsWorldRelay: PhysicsWorldRelay
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
        if goPhysics { sceneManager.playPhysics() }
        else { sceneManager.pausePhysics() }
    }

    var body: some View {
        VStack {
            PlayButtonsView(sceneManager: sceneManager, physicsWorldRelay: physicsWorldRelay)
            PlaySlidersGrid(commandRelay: commandRelay, physicsWorldRelay: physicsWorldRelay)
        }
    }
}
