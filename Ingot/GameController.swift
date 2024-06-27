// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

protocol GameEntityProtocol {

}

protocol SelectableProtocol {
    var isSelected: Bool { get }

    func deselect()
    func select()
    func toggleSelect()
}

final class GameController: ObservableObject {
    weak var commandSelection: CommandSelection!
    weak var gameScene: GameScene!
    weak var playgroundState: PlaygroundState!
    var selectionMarquee: SelectionMarquee!

    var entities = Set<GameEntity>()

    func postInit(_ commandSelection: CommandSelection, _ playgroundState: PlaygroundState) {
        self.commandSelection = commandSelection
        self.playgroundState = playgroundState
        self.selectionMarquee = SelectionMarquee(playgroundState)
    }

    func cancelAssignActionsMode() {
        playgroundState.assignSpaceActions = false
    }

    func click(_ clickDispatch: ClickDispatch) {
        if let entity = clickDispatch.entity {
            // Clicked on an entity; do selection stuff
            if clickDispatch.shift {
                toggleSelect(entity)
            } else {
                deselectAll()
                select(entity)
            }

            return
        }

        let entity: GameEntity

        switch commandSelection.clickToPlace {
        case .field:
            entity = newField(at: clickDispatch.location)

        case .gremlin:
            entity = newGremlin(at: clickDispatch.location)

        case .joint:
            entity = newJoint(at: clickDispatch.location)

        case .vertex:
            entity = newVertex(at: clickDispatch.location)

        case .waypoint:
            entity = newWaypoint(at: clickDispatch.location)
        }

        entities.insert(entity)

        deselectAll()
        select(entity)
    }

    func commitActions(duration: TimeInterval) {
        playgroundState.assignSpaceActions = false
    }

    func installGameScene(_ size: CGSize) -> GameScene {
        let gameScene = GameScene(size)

        self.gameScene = gameScene
        gameScene.postInit(self, self.playgroundState, self.selectionMarquee)

        return gameScene
    }

    func newField(at position: CGPoint) -> Field {
        let field = Field.make(at: position)

        gameScene.entitiesNode.addChild(field.avatar!.sceneNode)
        gameScene.entitiesNode.addChild(field.halo!.sceneNode)

        entities.insert(field)

        return field
    }

    func newGremlin(at position: CGPoint) -> Gremlin {
        let gremlin = Gremlin.make(at: position, avatarName: commandSelection.selectedGremlinTexture)

        gameScene.entitiesNode.addChild(gremlin.avatar!.sceneNode)
        gameScene.entitiesNode.addChild(gremlin.halo!.sceneNode)

        entities.insert(gremlin)

        return gremlin
    }

    func newJoint(at position: CGPoint) -> Joint {
        let joint = Joint.make(at: position)

        gameScene.entitiesNode.addChild(joint.avatar!.sceneNode)
        gameScene.entitiesNode.addChild(joint.halo!.sceneNode)

        entities.insert(joint)

        return joint
    }

    func newVertex(at position: CGPoint) -> Vertex {
        let vertex = Vertex.make(at: position)

        gameScene.entitiesNode.addChild(vertex.avatar!.sceneNode)
        gameScene.entitiesNode.addChild(vertex.halo!.sceneNode)

        entities.insert(vertex)

        return vertex
    }

    func newWaypoint(at position: CGPoint) -> Waypoint {
        let waypoint = Waypoint.make(at: position)

        gameScene.entitiesNode.addChild(waypoint.avatar!.sceneNode)
        gameScene.entitiesNode.addChild(waypoint.halo!.sceneNode)

        entities.insert(waypoint)

        return waypoint
    }

    func startActionsMode() {
        playgroundState.assignSpaceActions = true
    }
}
