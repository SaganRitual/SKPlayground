// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct SpaceActionsTabView: View {
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var shapeLab: ShapeLab
    @EnvironmentObject var spaceActionsState: SpaceActionsState

    @State private var duration: CGFloat = 0.5
    @State private var selectedPath: String? = nil

    func makeShapeListView() -> some View {
        return VStack {
            if shapeLab.paths.isEmpty || selectedPath == nil {
                Text("Create Followable Paths in The Shape Lab Tab")
                    .background(Color(NSColor.tertiarySystemFill))
                    .padding()
                    .border(Color(NSColor.quaternarySystemFill), width: 2)
            } else {
                Text("Or Select A Path to Follow")
                    .background(Color(NSColor.tertiarySystemFill))
                    .padding()
                    .border(Color(NSColor.quaternarySystemFill), width: 2)

                ShapeListView(
                    selection: $selectedPath, whichSet: .path, labelFrame: 100
                ).padding(.vertical)

                VStack {
                    Text("Duration: \(String(format: "%.2f", duration))")
                        .padding(.top)

                    HStack {
                        Text("0.1")
                        Slider(value: $duration, in: 0.1...10)
                        Text("5.0")
                    }
                    .padding([.horizontal])
                }

                Button("Create Action to Follow \(selectedPath!)") {
                    let pathId = shapeLab.paths.first(where: { $0.name == selectedPath! })!.uuid
                    let token = FollowPathActionToken(duration: duration, pathId: pathId)
                    gameController.commitFollowPathAction(token)
                }
            }
        }
        .onChange(of: shapeLab.paths) {
            selectedPath = shapeLab.paths.last?.name
        }
    }

    var body: some View {
        VStack {
            if spaceActionsState.assignSpaceActions {
                VStack {
                    Text("Duration: \(String(format: "%.2f", duration))")
                        .padding(.top)

                    HStack {
                        Text("0.1")
                        Slider(value: $duration, in: 0.1...5)
                        Text("5.0")
                    }
                    .padding([.horizontal])
                }

                HStack {
                    Button("Create Action(s) From Dragged Entity") {
                        // 1. Save the changes made to the entity as actions.
                        // 2. Add the new actions to the entity's action queue.
                        // 3. Update the scroll view with representations of the actions.
                        // 4. Reset the sprite and selection handle to their original states.
                        // 5. Show the "Click Here to Start" button again.
                        gameController.commitSpaceActions(duration: duration)
                    }

                    Button("Cancel") {
                        // 1. Cancel the operation.
                        // 2. Restore the original state of the Playground.
                        // 3. Show the "Click Here to Start" button again.
                        gameController.cancelAssignActionsMode()
                    }
                }
                .padding(.vertical)
            } else {
                VStack {
                    Button("Start Drag Operations") {
                        gameController.startActionsMode()
                    }
                    .padding(.bottom)

                    makeShapeListView()
                }
            }
        }
        .padding()
    }
}

#Preview {
    SpaceActionsTabView()
        .environmentObject(GameController())
        .environmentObject(ShapeLab())
        .environmentObject(SpaceActionsState())
}
