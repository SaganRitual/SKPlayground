// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class SKPScene: SKScene {
    weak var inputDelegate: InputDelegate?

    var mouseState = InputEvent.MouseState.idle

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
    }
}
