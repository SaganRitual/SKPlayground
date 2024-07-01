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

    var enableEdgeLoop = true
    var cachedEdgeLoop: SKPhysicsBody?
    var hotEdgeLoop: SKPhysicsBody? {
        get { self.physicsBody }
        set { self.physicsBody = newValue }
    }

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

        let shrunk = size * 0.95
        let origin = CGPoint(x: -shrunk.width / 2, y: -shrunk.height / 2)
        let pb = SKPhysicsBody(edgeLoopFrom: CGRect(origin: origin, size: shrunk))

        cachedEdgeLoop = pb

        Task { @MainActor in
            playgroundState.viewSize = self.size
        }
    }

    override func didMove(to view: SKView) {
    }

    override func update(_ currentTime: TimeInterval) {
        // Jumping through some hoops to make the scene edge loop
        // work properly when we disable/enable/recreate it repeatedly.
        // Note that this seems to make the edge work as a physics
        // object, but it doesn't always show up as an outline when
        // view.showsPhysics == true
        if enableEdgeLoop {
            if hotEdgeLoop == nil {
                hotEdgeLoop = cachedEdgeLoop
            } else if hotEdgeLoop !== cachedEdgeLoop {
                hotEdgeLoop = nil
            }
        } else {
            if hotEdgeLoop != nil {
                hotEdgeLoop = nil
            }
        }
    }
}
