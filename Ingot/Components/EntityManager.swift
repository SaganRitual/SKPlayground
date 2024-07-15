// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import Foundation

final class EntityManager {
    var entities = Set<GameEntity>()

    weak var relayManager: RelayManager!
    weak var sceneManager: SKPScene!
    weak var workflowRelay: WorkflowRelay!

    private weak var hotDragTarget: GameEntity?
    private var hotDragSubhandle: SelectionHaloRS.Directions?

    func singleSelected() -> Gremlin? {
        let selected = getSelected()
        if selected.count == 1 {
            return selected.first as? Gremlin
        } else {
            return nil
        }
    }
}

extension EntityManager {
    func commitFollowPathAction(path: [Vertex], for entity: GameEntity) {
        print("commitFollowPathAction")
    }

    func commitSpaceActions(for entity: GameEntity) {
        print("commitSpaceActions")
    }

    func setSpaceActionsMode(for entity: GameEntity) {
        print("setSpaceActionsMode")
    }
}

extension EntityManager {
    func moveSelected(_ anchorTarget: CGPoint) {
        let hotAnchor = Utility.forceUnwrap(hotDragTarget?.dragAnchor)
        let delta = anchorTarget - hotAnchor

        getSelected().forEach { entity in
            let anchor = Utility.forceUnwrap(entity.dragAnchor)
            entity.position = anchor + delta
        }
    }

    func roscaleSelected(_ mousePosition: CGPoint) {
        let hotAnchor = Utility.forceUnwrap(hotDragTarget?.dragAnchor)

        let delta = mousePosition - hotAnchor
        let distance = delta.magnitude
        let scale = max(1, distance / SelectionHaloRS.radius)
        var rotation = atan2(delta.y, delta.x)

        let subhandle = Utility.forceUnwrap(hotDragSubhandle)

        switch subhandle {
        case .n: rotation -= .pi / 2
        case .e: rotation += 0
        case .s: rotation += .pi / 2
        case .w: rotation += .pi
        }

        let rDelta = rotation - Utility.forceUnwrap(hotDragTarget?.rotationAnchor)
        let sDelta = scale - Utility.forceUnwrap(hotDragTarget?.scaleAnchor)

        getSelected().forEach { entity in
            entity.rotation = entity.rotationAnchor! + rDelta
            entity.scale = entity.scaleAnchor! + sDelta
        }
    }

    func setDragAnchors(_ anchorEntity: GameEntity, _ subhandleDirection: SelectionHaloRS.Directions? = nil) {
        hotDragTarget = anchorEntity
        hotDragSubhandle = subhandleDirection

        getSelected().forEach { entity in
            entity.dragAnchor = entity.position
            entity.rotationAnchor = entity.rotation
            entity.scaleAnchor = entity.scale
        }
    }
}

extension EntityManager {
    func newEntity(at position: CGPoint) -> GameEntity {
        switch workflowRelay.clickToPlace {
        case .field:
            return placeField(at: position)
        case .gremlin:
            return placeGremlin(at: position)
        case .joint:
            return placeJoint(at: position)
        case .vertex:
            return placeVertex(at: position)
        }
    }

    func placeField(at position: CGPoint) -> Field {
        let field = Field.make(at: position, fieldType: workflowRelay.fieldType)
        postPlace(field)
        return field
    }

    func placeGremlin(at position: CGPoint) -> Gremlin {
        let gremlin = Gremlin.make(at: position, avatarName: workflowRelay.avatarName)
        postPlace(gremlin)
        return gremlin
    }

    func placeJoint(at position: CGPoint) -> Joint {
        let joint = Joint.make(at: position, type: workflowRelay.jointType)
        postPlace(joint)
        return joint
    }

    func placeVertex(at position: CGPoint) -> Vertex {
        let vertex = Vertex.make(at: position)
        postPlace(vertex)
        return vertex
    }

    private func postPlace(_ entity: GameEntity) {
        entities.insert(entity)
        sceneManager.addEntity(entity)
    }
}

extension EntityManager {
    func commitMarqueeSelect(_ entities: Set<GameEntity>, _ shiftKey: Bool) {
        if shiftKey {
            entities.forEach { toggleSelect($0) }
        } else {
            deselectAll()
            entities.forEach { select($0) }
        }
    }

    func deselect(_ entity: GameEntity) {
        entity.deselect()

        let selected = getSelected()
        if selected.count == 1 {
            let entity = Utility.forceUnwrap(selected.first)
            relayManager.activatePhysicsRelay(for: entity)
        } else {
            relayManager.activatePhysicsRelay(for: nil)
        }
    }

    func deselectAll() {
        entities.forEach { deselect($0) }
    }

    func getSelected() -> Set<GameEntity> {
        Set(entities.compactMap({ $0.isSelected ? $0 : nil }))
    }

    func select(_ entity: GameEntity) {
        entity.select()
        relayManager.activatePhysicsRelay(for: entity)
    }

    func toggleSelect(_ entity: GameEntity) {
        if entity.isSelected {
            deselect(entity)
        } else {
            select(entity)
        }
    }
}
