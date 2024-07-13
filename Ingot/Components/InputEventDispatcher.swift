// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

struct GestureEvent {
    enum GestureState {
        case click, drag, dragEnd, idle, limbo, rightClick
    }

    let inputEvent: SKPScene.InputEvent
    let newGestureState: GestureState
    let oldGestureState: GestureState
}

final class InputEventDispatcher: SKPScene.InputDelegate {
    protocol GestureDelegate: AnyObject {
        func gestureEvent(_ event: GestureEvent)
    }

    weak var gestureDelegate: GestureDelegate?
    var gestureState = GestureEvent.GestureState.idle

    let reportState: Bool

    init(reportState: Bool = false) {
        self.reportState = reportState
    }

    func inputEvent(_ inputEvent: SKPScene.InputEvent) {
        let oldGestureState = gestureState

        switch(inputEvent.oldMouseState, inputEvent.newMouseState) {
        case (.leftDown, .leftDrag): fallthrough
        case (.leftDrag, .leftDrag):
            gestureState = .drag

        case (.idle, .leftDown): fallthrough
        case (.idle, .rightDown):
            gestureState = .limbo

        case (.leftDown, .idle):
            gestureState = .click
        case (.leftDrag, .idle):
            gestureState = .dragEnd
        case (.rightDown, .idle):
            gestureState = .rightClick
        default:
            fatalError("You thought this couldn't happen \(inputEvent.oldMouseState), \(inputEvent.newMouseState)")
        }

        if reportState {
            print("New InputEventDispatcher state = \(gestureState)")
        }

        if let gd = gestureDelegate {
            gd.gestureEvent(GestureEvent(
                inputEvent: inputEvent,
                newGestureState: gestureState,
                oldGestureState: oldGestureState
            ))
        }

        // Some states are now complete so we return to idle state. Other states have begun
        // but haven't ended yet so we just leave our state where it is until the next input
        switch gestureState {
        case .click:
            fallthrough
        case .dragEnd:
            fallthrough
        case .rightClick:
            gestureState = .idle

        default:
            break
        }
    }
}
