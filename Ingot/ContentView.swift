// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ContentView: View {
    static let sceneMinimumSize = CGSize(width: 1024, height: 1024)

    let contextMenuManager = ContextMenuManager()
    let entityManager = EntityManager()
    let gestureEventDispatcher = GestureEventDispatcher()
    let inputEventDispatcher = InputEventDispatcher()
    let sceneManager = SKPScene(size: Self.sceneMinimumSize)
    let selectionMarquee = SelectionMarquee()
    let workflowManager = WorkflowManager()

    let relayManager = RelayManager()

    var body: some View {
        HStack(alignment: .top) {
            SKPSpriteView(scene: sceneManager)
                .frame(minWidth: Self.sceneMinimumSize.width, minHeight: Self.sceneMinimumSize.height)
                .padding()
                .onAppear {
                    contextMenuManager.entityManager = entityManager
                    contextMenuManager.gestureEventDispatcher = gestureEventDispatcher
                    contextMenuManager.workflowManager = workflowManager

                    entityManager.relayManager = relayManager
                    entityManager.sceneManager = sceneManager
                    entityManager.workflowRelay = relayManager.workflowRelay

                    entityManager.postInit()

                    gestureEventDispatcher.contextMenuManager = contextMenuManager
                    gestureEventDispatcher.entityManager = entityManager
                    gestureEventDispatcher.selectionMarquee = selectionMarquee
                    gestureEventDispatcher.workflowManager = workflowManager

                    inputEventDispatcher.gestureDelegate = gestureEventDispatcher

                    sceneManager.inputDelegate = inputEventDispatcher
                    sceneManager.gameSceneRelay = relayManager.gameSceneRelay

                    sceneManager.addChild(selectionMarquee.marqueeRootNode)

                    relayManager.activatePhysicsRelay(for: nil)

                    workflowManager.workflowRelay = relayManager.workflowRelay
                }

            VStack {
                // Passing these variables directly into the view because if we
                // pass an observable object like the game scene relay, SwiftUI
                // wants to update everything in the VStack whenever mousePosition
                // changes.
                PlaygroundStatusView(
                    viewSize: relayManager.gameSceneRelay.viewSize,
                    mousePosition: relayManager.gameSceneRelay.mousePosition
                )
                .padding()
                .border(Color(NSColor.secondarySystemFill))
                .padding([.horizontal, .top])

                CommandView(
                    commandRelay: relayManager.commandRelay,
                    workflowRelay: relayManager.workflowRelay,
                    sceneManager: sceneManager
                )
                .padding()
                .border(Color(NSColor.secondarySystemFill))
                .padding(.horizontal)

                ZStack {
                    PhysicsBodyConfigurator(selectedPhysicsRelay: relayManager.selectedPhysicsRelay)
                    PhysicsFieldConfigurator(selectedPhysicsRelay: relayManager.selectedPhysicsRelay)
                    PhysicsJointConfigurator(selectedPhysicsRelay: relayManager.selectedPhysicsRelay)
                    PhysicsWorldConfigurator(selectedPhysicsRelay: relayManager.selectedPhysicsRelay)
                }
                .padding()
                .border(Color(NSColor.secondarySystemFill))
                .padding(.horizontal)
            }
        }
        .monospaced()
    }
}

#Preview {
    ContentView()
}
