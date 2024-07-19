// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ContentView: View {
    @State private var activeTab = CommandRelay.ActiveTab.physicsWorld
    @StateObject var gameController = GameController()

    var body: some View {
        HStack(alignment: .top) {
            SKPSpriteView(scene: gameController.sceneManager)
                .frame(
                    minWidth: GameController.sceneMinimumSize.width,
                    minHeight: GameController.sceneMinimumSize.height
                )
                .padding()
                .onAppear { gameController.postInit() }

            VStack {
                PlaygroundStatusView(gameSceneRelay: gameController.gameSceneRelay)
                .padding()
                .border(Color(NSColor.secondarySystemFill))
                .padding(.top)

                CommandView(
                    commandRelay: gameController.commandRelay,
                    workflowRelay: gameController.workflowRelay,
                    sceneManager: gameController.sceneManager
                )
                .padding()
                .border(Color(NSColor.secondarySystemFill))

                VStack {
                    Text("Configure")
                        .underline()
                        .padding(.bottom)

                    TabView {
                        PhysicsWorldConfigurator(
                            physicsMaskNamesManager: gameController.physicsMaskNamesManager,
                            physicsWorldRelay: gameController.physicsWorldRelay
                        )
                            .tabItem {
                                Label("World", systemImage: "globe.europe.africa")
                            }
                            .tag(CommandRelay.ActiveTab.physicsWorld)

                        PhysicsEntityConfigurators(
                            gameController: gameController,
                            physicsMaskNamesManager: gameController.physicsMaskNamesManager
                        )
                            .tabItem {
                                Label("Physics Entity", systemImage: "atom")
                            }
                            .tag(CommandRelay.ActiveTab.physicsEntity)

                        PhysicsActionConfigurators(
                            actionRelay: gameController.actionRelay,
                            gameController: gameController
                        )
                            .tabItem {
                                Label("Physics Actions", systemImage: "bolt.fill")
                            }
                            .tag(CommandRelay.ActiveTab.physicsAction)

                        SpaceActionConfigurators()
                            .tabItem {
                                Label("Space Actions", systemImage: "move.3d")
                            }
                            .tag(CommandRelay.ActiveTab.spaceAction)

                        ShapeLabView()
                            .tabItem {
                                Label("Shape Lab", systemImage: "point.bottomleft.forward.to.point.topright.scurvepath")
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
