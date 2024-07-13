// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ContentView: View {
    let contextMenuManager = ContextMenuManager()
    let entityManager = EntityManager()
    let gestureEventDispatcher = GestureEventDispatcher()
    let inputEventDispatcher = InputEventDispatcher()
    let sceneManager = SKPScene(size: CGSize(width: 1024, height: 768))
    let selectionMarquee = SelectionMarquee()
    let workflowManager = WorkflowManager()

    var body: some View {
        SKPSpriteView(scene: sceneManager)
            .onAppear {
                contextMenuManager.gestureEventDispatcher = gestureEventDispatcher
                contextMenuManager.placementManager = workflowManager

                entityManager.placementManager = workflowManager
                entityManager.sceneManager = sceneManager

                gestureEventDispatcher.contextMenuManager = contextMenuManager
                gestureEventDispatcher.entityManager = entityManager
                gestureEventDispatcher.selectionMarquee = selectionMarquee

                inputEventDispatcher.gestureDelegate = gestureEventDispatcher

                sceneManager.inputDelegate = inputEventDispatcher

                sceneManager.addChild(selectionMarquee.marqueeRootNode)
            }
    }
}

#Preview {
    ContentView()
}
