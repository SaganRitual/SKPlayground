// We are a way for the cosmos to know itself. -- C. Sagan

import AppKit
import Foundation
import SpriteKit

extension SKPScene {
    protocol InputDelegate: AnyObject {
        func inputEvent(_ event: InputEvent)
    }

    struct InputEvent {
        // swiftlint:disable nesting
        enum MouseState { case idle, leftDown, leftDrag, rightDown }
        // swiftlint:enable nesting

        let control: Bool
        let location: CGPoint
        let newMouseState: MouseState
        let nsEvent: NSEvent
        let oldMouseState: MouseState
        let scene: SKPScene
        let shift: Bool

        init(from event: NSEvent, newMouseState: MouseState, oldMouseState: MouseState, scene: SKPScene) {
            self.control = event.modifierFlags.contains(.control)
            self.location = event.location(in: scene)
            self.newMouseState = newMouseState
            self.nsEvent = event
            self.oldMouseState = oldMouseState
            self.scene = scene
            self.shift = event.modifierFlags.contains(.shift)
        }

        func getTopEntity() -> GameEntity? {
            return getTopNode()?.getOwnerEntity()
        }

        private func getTopNode() -> SKNode? {
            scene.nodes(at: location).first(where: { $0.getOwnerEntity() != nil })
        }
    }

    private func publish(_ nsEvent: NSEvent, _ newMouseState: InputEvent.MouseState) {
        let oldms = mouseState
        mouseState = newMouseState

        let inputEvent = InputEvent(from: nsEvent, newMouseState: mouseState, oldMouseState: oldms, scene: self)

        gameSceneRelay.mousePosition = inputEvent.location

        inputDelegate?.inputEvent(inputEvent)
    }

    override func mouseDown(with event: NSEvent) { publish(event, .leftDown) }
    override func mouseDragged(with event: NSEvent) { publish(event, .leftDrag) }
    override func mouseMoved(with event: NSEvent) { publish(event, .idle) }
    override func mouseUp(with event: NSEvent) { publish(event, .idle) }
    override func rightMouseDown(with event: NSEvent) { publish(event, .rightDown) }
    override func rightMouseUp(with event: NSEvent) { publish(event, .idle) }
}
