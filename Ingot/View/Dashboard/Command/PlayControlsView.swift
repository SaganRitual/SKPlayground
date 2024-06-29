// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PlayControlsView: View {
    @EnvironmentObject var commandSelection: CommandSelection
    @EnvironmentObject var gameController: GameController

    @State private var isPlaying = false
    @State private var applyToActions = false
    @State private var applyToPhysics = false

    func updateActionsState() {
        let goActions = isPlaying && applyToActions
        if goActions { gameController.startActions() }
        else { gameController.stopActions() }
    }

    func updatePhysicsState() {
        let goPhysics = isPlaying && applyToPhysics
        if goPhysics { gameController.startPhysics() }
        else { gameController.stopPhysics() }
    }

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack(spacing: 50) {
                Button("Run Actions") {
                    gameController.startActions()
                }

                Button("Run Actions on Selected") {
                    gameController.startActionsOnSelected()
                }

                Button("Stop Actions") {
                    gameController.stopActions()
                }
            }

            HStack {
                BasicScalarSlider(
                    scalar: $commandSelection.actionsSpeed,
                    scalarView: Text(String(format: "%.1f", commandSelection.actionsSpeed)),
                    title: Text("Actions Speed"),
                    minLabel: "0", maxLabel: "10", range: 0...10,
                    widthSlider: 180, widthTitle: 110
                )
                .onChange(of: commandSelection.actionsSpeed) {
                    gameController.setActionsSpeed(commandSelection.actionsSpeed)
                }

                BasicScalarSlider(
                    scalar: $commandSelection.physicsSpeed,
                    scalarView: Text(String(format: "%.1f", commandSelection.physicsSpeed)),
                    title: Text("Physics Speed"),
                    minLabel: "0", maxLabel: "10", range: 0...10,
                    widthSlider: 180, widthTitle: 110
                )
                .onChange(of: commandSelection.physicsSpeed) {
                    gameController.setPhysicsSpeed(commandSelection.physicsSpeed)
                }
            }
        }
        .padding()
    }
}

#Preview {
    PlayControlsView()
        .environmentObject(CommandSelection())
}
