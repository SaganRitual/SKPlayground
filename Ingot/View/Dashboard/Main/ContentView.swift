// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ContentView: View {
    static let sceneMinimumSize = CGSize(width: 1024, height: 1024)

    let contextMenuManager = ContextMenuManager()
    let entityManager = EntityManager()
    let gestureEventDispatcher = GestureEventDispatcher()
    let inputEventDispatcher = InputEventDispatcher()
    let physicsMaskNamesManager = PhysicsMaskNamesManager()
    let relayManager = RelayManager()
    let sceneManager = SKPScene(size: Self.sceneMinimumSize)
    let selectionMarquee = SelectionMarquee()
    let workflowManager = WorkflowManager()

    @State private var activeTab = CommandRelay.ActiveTab.physicsWorld

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

                    gestureEventDispatcher.contextMenuManager = contextMenuManager
                    gestureEventDispatcher.entityManager = entityManager
                    gestureEventDispatcher.selectionMarquee = selectionMarquee
                    gestureEventDispatcher.workflowManager = workflowManager

                    inputEventDispatcher.gestureDelegate = gestureEventDispatcher

                    sceneManager.gameSceneRelay = relayManager.gameSceneRelay
                    sceneManager.inputDelegate = inputEventDispatcher
                    sceneManager.physicsWorldRelay = relayManager.physicsWorldRelay

                    sceneManager.addChild(selectionMarquee.marqueeRootNode)

                    relayManager.subscribeToRelays(entityManager: entityManager, sceneManager: sceneManager)
                    relayManager.physicsWorldRelay.loadState(from: sceneManager)
                    relayManager.activatePhysicsRelay(for: nil)

                    workflowManager.workflowRelay = relayManager.workflowRelay
                }

            VStack {
                // Passing these variables directly into the view because if we
                // pass an observable object like the game scene relay, SwiftUI
                // wants to update everything in the VStack whenever mousePosition
                // changes.
                PlaygroundStatusView(gameSceneRelay: relayManager.gameSceneRelay)
                .padding()
                .border(Color(NSColor.secondarySystemFill))
                .padding(.top)

                CommandView(
                    commandRelay: relayManager.commandRelay,
                    workflowRelay: relayManager.workflowRelay,
                    sceneManager: sceneManager
                )
                .padding()
                .border(Color(NSColor.secondarySystemFill))

                VStack {
                    Text("Configure")
                        .underline()
                        .padding(.bottom)

                    TabView {
                        PhysicsWorldConfigurator(
                            physicsMaskNamesManager: physicsMaskNamesManager,
                            physicsWorldRelay: relayManager.physicsWorldRelay
                        )
                            .tabItem {
                                Label("World", systemImage: "globe.europe.africa")
                            }
                            .tag(CommandRelay.ActiveTab.physicsWorld)

                        PhysicsEntityConfigurators(
                            physicsMaskNamesManager: physicsMaskNamesManager,
                            selectedPhysicsRelay: relayManager.selectedPhysicsRelay
                        )
                            .tabItem {
                                Label("Physics Entity", systemImage: "globe.europe.africa")
                            }
                            .tag(CommandRelay.ActiveTab.physicsEntity)

                        Text("Physics Actions")
                            .tabItem {
                                Label("Physics Actions", systemImage: "globe.europe.africa")
                            }
                            .tag(CommandRelay.ActiveTab.physicsAction)

                        Text("Space Actions")
                            .tabItem {
                                Label("Space Actions", systemImage: "globe.europe.africa")
                            }
                            .tag(CommandRelay.ActiveTab.spaceAction)
                    }
                }
                .padding()
                .border(Color(NSColor.secondarySystemFill))
                .padding(.bottom)
            }
            .padding(.trailing)
        }
        .monospaced()
    }
}

#Preview {
    ContentView()
}
