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
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Button(action: { isPlaying.toggle() }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.largeTitle)
                }
                .padding(.trailing)
                .onChange(of: isPlaying) {
                    updateActionsState()
                    updatePhysicsState()
                }

                VStack(alignment: .trailing, spacing: 10) {
                    Toggle("Actions", isOn: $applyToActions)
                        .onChange(of: applyToActions) { updateActionsState() }

                    Toggle("Physics", isOn: $applyToPhysics)
                        .onChange(of: applyToPhysics) { updatePhysicsState() }
                }
                .padding(.trailing, 30)

                VStack(spacing: -25) {
                    BasicScalarSlider(
                        scalar: $commandSelection.actionsSpeed,
                        scalarView: Text(String(format: "%.1f", commandSelection.actionsSpeed)),
                        title: Text("Speed"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )
                    .onChange(of: commandSelection.actionsSpeed) {
                        gameController.setActionsSpeed(commandSelection.actionsSpeed)
                    }

                    BasicScalarSlider(
                        scalar: $commandSelection.physicsSpeed,
                        scalarView: Text(String(format: "%.1f", commandSelection.physicsSpeed)),
                        title: Text("Speed"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )
                    .onChange(of: commandSelection.physicsSpeed) {
                        gameController.setPhysicsSpeed(commandSelection.physicsSpeed)
                    }
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
