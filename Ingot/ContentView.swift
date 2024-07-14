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

    @StateObject var relayManager = RelayManager()

    var body: some View {
        HStack(alignment: .top) {
            SKPSpriteView(scene: sceneManager)
                .frame(minWidth: Self.sceneMinimumSize.width, minHeight: Self.sceneMinimumSize.height)
                .padding()
                .onAppear {
                    contextMenuManager.entityManager = entityManager
                    contextMenuManager.gestureEventDispatcher = gestureEventDispatcher
                    contextMenuManager.workflowManager = workflowManager

                    entityManager.sceneManager = sceneManager
                    entityManager.workflowRelay = relayManager.workflowRelay

                    gestureEventDispatcher.contextMenuManager = contextMenuManager
                    gestureEventDispatcher.entityManager = entityManager
                    gestureEventDispatcher.selectionMarquee = selectionMarquee
                    gestureEventDispatcher.workflowManager = workflowManager

                    inputEventDispatcher.gestureDelegate = gestureEventDispatcher

                    sceneManager.inputDelegate = inputEventDispatcher
                    sceneManager.gameSceneRelay = relayManager.gameSceneRelay

                    sceneManager.addChild(selectionMarquee.marqueeRootNode)

                    workflowManager.workflowRelay = relayManager.workflowRelay
                }

            VStack {
                PlaygroundStatusView(gameSceneRelay: relayManager.gameSceneRelay)
                    .padding()
                    .border(Color(NSColor.secondarySystemFill))
                    .padding()
                
                CommandView(
                    commandRelay: relayManager.commandRelay,
                    workflowRelay: relayManager.workflowRelay,
                    sceneManager: sceneManager
                )
                    .padding()
                    .border(Color(NSColor.secondarySystemFill))
                    .padding()
//
//                PhysicsBodyConfigurator()
//                    .environmentObject(SelectedPhysicsRelay(PhysicsObjectType.body(PhysicsBodyRelay())))
            }
        }
        .monospaced()
    }
}

#Preview {
    ContentView()
}
