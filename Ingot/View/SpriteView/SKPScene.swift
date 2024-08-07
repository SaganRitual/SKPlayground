// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class SKPScene: SKScene {
    weak var gameSceneRelay: GameSceneRelay!
    weak var inputDelegate: InputDelegate?
    weak var physicsWorldRelay: PhysicsWorldRelay!

    var edgeLoop: SKPhysicsBody?
    var firstPass = true
    var mouseState = InputEvent.MouseState.idle
    var physicsRunSpeed: CGFloat = 1

    let entitiesNode = SKNode()

    override init(size: CGSize) {
        super.init(size: size)
        addChild(entitiesNode)

        physicsWorld.gravity = .zero

        scaleMode = .resizeFill
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = .black
        scaleMode = .resizeFill

        Task { @MainActor in
            gameSceneRelay?.viewSize = view.scene?.size ?? .zero
        }
    }

    override func didChangeSize(_ oldSize: CGSize) {
        let origin = CGPoint(x: -size.width / 2, y: -size.height / 2)
        let pb = SKPhysicsBody(edgeLoopFrom: CGRect(origin: origin, size: size))

        edgeLoop = pb

        Task { @MainActor in
            if firstPass || physicsBody != nil {
                physicsBody = edgeLoop
                firstPass = false
            }

            physicsWorldRelay.loadState(from: self)
            gameSceneRelay?.viewSize = size
        }
    }
}
