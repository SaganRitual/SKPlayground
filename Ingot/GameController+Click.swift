// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

extension GameController {
    
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

    func newField(at position: CGPoint) -> Field {
        let field = Field.make(at: position)

        gameScene.entitiesNode.addChild(field.face.rootSceneNode)

        entities.insert(field)

        return field
    }

    func newGremlin(at position: CGPoint) -> Gremlin {
        let gremlin = Gremlin.make(at: position, avatarName: commandSelection.selectedGremlinTexture)

        gameScene.entitiesNode.addChild(gremlin.face.rootSceneNode)

        entities.insert(gremlin)

        return gremlin
    }

    func newJoint(at position: CGPoint) -> Joint {
        let joint = Joint.make(at: position)

        gameScene.entitiesNode.addChild(joint.face.rootSceneNode)

        entities.insert(joint)

        return joint
    }

    func newVertex(at position: CGPoint) -> Vertex {
        let vertex = Vertex.make(at: position)

        gameScene.entitiesNode.addChild(vertex.face.rootSceneNode)

        entities.insert(vertex)

        return vertex
    }

    func newWaypoint(at position: CGPoint) -> Waypoint {
        let waypoint = Waypoint.make(at: position)

        gameScene.entitiesNode.addChild(waypoint.face.rootSceneNode)

        entities.insert(waypoint)

        return waypoint
    }

}
