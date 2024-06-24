// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class GameController: ObservableObject {
    weak var playgroundState: PlaygroundState!

    func postInit(_ playgroundState: PlaygroundState) {
        self.playgroundState = playgroundState
    }

    func cancelAssignActionsMode() {
        playgroundState.assignSpaceActions = false
    }

    func commitActions(duration: TimeInterval) {
        playgroundState.assignSpaceActions = false
    }

    func startActionsMode() {
        playgroundState.assignSpaceActions = true
    }
}
