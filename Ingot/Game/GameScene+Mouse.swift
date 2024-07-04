// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

extension GameScene {

    override func mouseDown(with event: NSEvent) {
        mouseState = .mouseDown
    }

    override func mouseDragged(with event: NSEvent) {
        let mouseDispatch = MouseDispatch(from: event, scene: self)
        playgroundState.mousePosition = mouseDispatch.location

        if case .mouseDown = mouseState {
            dragBegin(mouseDispatch)
        }

        let dragDispatch = DragDispatch.continue(hotDragTarget, mouseDispatch)

        switch mouseState {
        case .dragBackground:
            selectionMarquee.drag(dragDispatch)
        case .dragHandle:
            gameController.drag(dragDispatch)
        case .dragSubhandle:
            let rsDragDispatch = DragDispatch.continueRS(hotDragTarget, hotDragSubhandle!, mouseDispatch)
            gameController.subhandleDrag(rsDragDispatch)
        default:
            fatalError("Nine out of ten tech CEOs say this can't happen")
        }
    }

    override func mouseMoved(with event: NSEvent) {
        let mouseDispatch = MouseDispatch(from: event, scene: self)
        playgroundState.mousePosition = mouseDispatch.location
    }

    override func mouseUp(with event: NSEvent) {
        let mouseDispatch = MouseDispatch(from: event, scene: self)

        switch mouseState {
        case .dragBackground:
            let dragDispatch = DragDispatch.end(nil, mouseDispatch)
            selectionMarquee.drag(dragDispatch)

            let vertexA = selectionMarquee.dragAnchor
            let rectangle = makeRectangle(vertexA: vertexA, vertexB: dragDispatch.location)
            let enclosedNodes = getNodesInRectangle(rectangle)
            let enclosedEntities = Set(enclosedNodes.compactMap { $0.getOwnerEntity() })
            gameController.commitMarqueeSelect(enclosedEntities, dragDispatch)

        case .dragHandle:
            break

        case .dragSubhandle:
            break

        case .mouseDown:
            // Note that we're checking the nodes for owner entity. We shouldn't have to
            // do it, but sometimes nodes(at:) will include nodes we don't want,
            // such as the entities node, which has zero size and technically sits at the origin
            guard let topNode = getTopNode(at: mouseDispatch.location) else {
                // Nothing at the click point; create an entity
                let clickDispatch = ClickDispatch.click(nil, mouseDispatch)
                gameController.click(clickDispatch)
                return
            }

            guard let entity = topNode.getOwnerEntity() else {
                assert(false, "Got a node with no owner? See getTopNode()")
                return
            }

            let clickDispatch = ClickDispatch.click(entity, mouseDispatch)
            gameController.click(clickDispatch)

        case .idle:
            fatalError("Reputable scholars say this can't happen")
        }

        mouseState = .idle
    }

    override func rightMouseUp(with event: NSEvent) {
        let mouseDispatch = MouseDispatch(from: event, scene: self)

        // Note that we're checking the nodes for owner entity. We shouldn't have to
        // do it, but sometimes nodes(at:) will include nodes we don't want,
        // such as the entities node, which has zero size and technically sits at the origin
        guard let topNode = getTopNode(at: mouseDispatch.location) else {
            // Nothing at the click point; background context menu
            gameController.showContextMenu = .background
            updateContextMenu(with: event)
            return
        }

        if topNode.getOwnerEntity() == nil {
            assert(false, "Got a node with no owner? See getTopNode()")
            return
        }

        gameController.showContextMenu = .entity

        updateContextMenu(with: event)
    }

    @objc func selectGremlinTexture(_ sender: Any?) {
        let menuItem = Utility.forceCast(sender, to: NSMenuItem.self)
        let textureName = Utility.forceCast(menuItem.representedObject, to: String.self)
        gameController.commandSelection.selectedGremlinTexture = textureName
        gameController.commandSelection.clickToPlace = .gremlin
    }

    @objc func selectPhysicsField(_ sender: Any?) {
        let menuItem = Utility.forceCast(sender, to: NSMenuItem.self)
        let fieldName = Utility.forceCast(menuItem.representedObject, to: String.self)
        gameController.commandSelection.selectedPhysicsFieldType = fieldName
        gameController.commandSelection.clickToPlace = .field
    }

    @objc func selectPhysicsJoint(_ sender: Any?) {
        let menuItem = Utility.forceCast(sender, to: NSMenuItem.self)
        let jointName = Utility.forceCast(menuItem.representedObject, to: String.self)
        gameController.commandSelection.selectedPhysicsJointType = jointName
        gameController.commandSelection.clickToPlace = .joint
    }

    func updateContextMenu(with event: NSEvent) {
        let menu = NSMenu()
        var iField: NSMenuItem!
        var iGremlin: NSMenuItem!
        var iJoint: NSMenuItem!
        var iVertex: NSMenuItem!

        switch gameController.showContextMenu {
        case .background:
            iField = NSMenuItem(title: "Place Field", action: nil, keyEquivalent: "")
            iGremlin = NSMenuItem(title: "Place Gremlin", action: nil, keyEquivalent: "")
            iJoint = NSMenuItem(title: "Place Joint", action: nil, keyEquivalent: "")
            iVertex = NSMenuItem(title: "Place Vertex", action: nil, keyEquivalent: "")

        case .entity:
            iField = NSMenuItem(title: "Attach Field", action: nil, keyEquivalent: "")
            iJoint = NSMenuItem(title: "Attach Joint", action: nil, keyEquivalent: "")

        default:
            fatalError()
        }

        makeFieldsSubmenu(menu, iField)
        makeGremlinsSubmenu(menu, iGremlin)
        makeJointsSubmenu(menu, iJoint)
        makeVerticesSubmenu(menu, iVertex)

        NSMenu.popUpContextMenu(menu, with: event, for: self.view!)
    }
}

private extension GameScene {
    func makeFieldsSubmenu(_ menu: NSMenu, _ iField: NSMenuItem?) {
        if let iField {
            iField.target = self
            menu.addItem(iField)

            let fieldsSubmenu = NSMenu()

            PhysicsFieldType.allCases.forEach { fieldType in
                let item = NSMenuItem(
                    title: fieldType.rawValue, action: #selector(selectPhysicsField), keyEquivalent: ""
                )

                item.representedObject = fieldType.rawValue
                item.target = self
                fieldsSubmenu.addItem(item)
            }

            iField.submenu = fieldsSubmenu
        }
    }

    func makeGremlinsSubmenu(_ menu: NSMenu, _ iGremlin: NSMenuItem?) {
        if let iGremlin {
            iGremlin.target = self
            menu.addItem(iGremlin)

            let gremlinsSubmenu = NSMenu()

            gameController.commandSelection.gremlinImageNames.forEach { name in
                let item = NSMenuItem(title: "", action: #selector(selectGremlinTexture), keyEquivalent: "")
                item.representedObject = name
                item.image = NSImage(named: name)
                item.target = self
                gremlinsSubmenu.addItem(item)
            }

            iGremlin.submenu = gremlinsSubmenu
        }
    }

    func makeJointsSubmenu(_ menu: NSMenu, _ iJoint: NSMenuItem?) {
        if let iJoint {
            iJoint.target = self
            menu.addItem(iJoint)

            let jointsSubmenu = NSMenu()

            PhysicsJointType.allCases.forEach { jointType in
                let item = NSMenuItem(
                    title: jointType.rawValue, action: #selector(selectPhysicsJoint), keyEquivalent: ""
                )
                item.representedObject = jointType.rawValue
                item.target = self
                jointsSubmenu.addItem(item)
            }

            iJoint.submenu = jointsSubmenu
        }
    }

    func makeVerticesSubmenu(_ menu: NSMenu, _ iVertex: NSMenuItem?) {
        if let iVertex {
            iVertex.target = self
            menu.addItem(iVertex)
        }
    }
}

private extension GameScene {

    // Remember: the selection controller needs to know about drag-entity-begin -- because that might
    // require the entity to be selected -- and drag-background-end -- because that's how you select
    // things with a selection marquee: by letting go of the mouse button

    func dragBegin(_ mouseDispatch: MouseDispatch) {
        guard let topNode = getTopNode(at: mouseDispatch.location) else {
            selectionMarquee.drag(DragDispatch.begin(nil, mouseDispatch))
            mouseState = .dragBackground
            return
        }

        guard let entity = topNode.getOwnerEntity() else {
            assert(false, "Got a node with no owner? See getTopNode()")
            return
        }

        if let haloRS = entity.face.halo as? SelectionHaloRS {
            if let direction = haloRS.getSubhandleDirection(topNode) {
                let rsDragDispatch = DragDispatch.beginRS(entity, direction, mouseDispatch)

                hotDragTarget = entity
                hotDragSubhandle = direction
                gameController.subhandleDrag(rsDragDispatch)
                mouseState = .dragSubhandle
                return
            }
        }

        let dragDispatch = DragDispatch.begin(entity, mouseDispatch)

        hotDragTarget = entity
        gameController.drag(dragDispatch)
        mouseState = .dragHandle
    }

    func getNodesInRectangle(_ rectangle: CGRect) -> [SKNode] {
        return entitiesNode.children.compactMap { node in
            guard rectangle.contains(node.position) else {
                return nil
            }

            if node.getOwnerEntity() == nil {
                return nil
            }

            return node
        }
    }

    func getTopNode(at position: CGPoint) -> SKNode? {
        nodes(at: position).first(where: { $0.getOwnerEntity() != nil })
    }

    func makeRectangle(vertexA: CGPoint, vertexB: CGPoint) -> CGRect {
        let LL = CGPoint(x: min(vertexA.x, vertexB.x), y: min(vertexA.y, vertexB.y))
        let UR = CGPoint(x: max(vertexA.x, vertexB.x), y: max(vertexA.y, vertexB.y))

        let size = CGSize(width: UR.x - LL.x, height: UR.y - LL.y)

        return CGRect(origin: LL, size: size)
    }

}
