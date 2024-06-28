// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit
 
class GameScene: SKScene {
    var playgroundState: PlaygroundState!
    var gameController: GameController!
    var selectionMarquee: SelectionMarquee!

    let cameraNode = SKCameraNode()
    let entitiesNode = SKNode()

    var mouseState = MouseState.idle
    var hotDragTarget: GameEntity?
    var hotDragSubhandle: SelectionHaloRS.Directions?

    var enableEdgeLoop = false
    var sceneEdgeLoop: SKPhysicsBody!

    enum MouseState {
        case dragBackground, dragHandle, dragSubhandle, idle, mouseDown
    }

    init(_ size: CGSize) {
        super.init(size: size)

        backgroundColor = .black
        isUserInteractionEnabled = true
        scaleMode = .resizeFill

        physicsWorld.gravity = .zero
        physicsWorld.speed = 1

        addChild(cameraNode)
        camera = cameraNode

        addChild(entitiesNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func postInit(_ gameController: GameController, _ playgroundState: PlaygroundState, _ selectionMarquee: SelectionMarquee) {
        self.gameController = gameController
        self.playgroundState = playgroundState
        self.selectionMarquee = selectionMarquee

        cameraNode.position = playgroundState.cameraPosition
        cameraNode.setScale(playgroundState.cameraScale)

        addChild(selectionMarquee.marqueeRootNode)
    }

    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)

        let origin = CGPoint(x: -size.width / 2, y: -size.height / 2)
        let pb = SKPhysicsBody(edgeLoopFrom: CGRect(origin: origin, size: size))

        print("Create edge loop at \(origin) size \(size)")

        self.sceneEdgeLoop = pb

        Task { @MainActor in
            playgroundState.viewSize = self.size
        }
    }

    override func didMove(to view: SKView) {
    }

    override func update(_ currentTime: TimeInterval) {
        if enableEdgeLoop && self.physicsBody == nil {
            self.run(SKAction.run {
                self.physicsBody = self.sceneEdgeLoop
            })
        } else {
            self.physicsBody = nil
        }
    }
}
