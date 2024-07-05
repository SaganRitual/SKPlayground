// We are a way for the cosmos to know itself. -- C. Sagan

import AppKit
import Foundation

private extension GameScene {
    struct ContextMenuArguments {
        let stringArgument: String?
        let event: NSEvent?

        init(stringArgument: String? = nil, event: NSEvent? = nil) {
            self.stringArgument = stringArgument
            self.event = event
        }
    }

    func makeFieldsSubmenu(_ menu: NSMenu, _ iField: NSMenuItem?, _ event: NSEvent) {
        if let iField {
            iField.target = self
            menu.addItem(iField)

            let fieldsSubmenu = NSMenu()

            PhysicsFieldType.allCases.forEach { fieldType in
                let item = NSMenuItem(
                    title: fieldType.rawValue, action: #selector(selectPhysicsField), keyEquivalent: ""
                )

                item.representedObject = ContextMenuArguments(stringArgument: fieldType.rawValue, event: event)
                item.target = self
                fieldsSubmenu.addItem(item)
            }

            iField.submenu = fieldsSubmenu
        }
    }

    func makeGremlinsSubmenu(_ menu: NSMenu, _ iGremlin: NSMenuItem?, _ event: NSEvent) {
        if let iGremlin {
            iGremlin.target = self
            menu.addItem(iGremlin)

            let gremlinsSubmenu = NSMenu()

            gameController.commandSelection.gremlinImageNames.forEach { name in
                let item = NSMenuItem(title: "", action: #selector(selectGremlinTexture), keyEquivalent: "")
                item.representedObject = ContextMenuArguments(stringArgument: name, event: event)
                item.image = NSImage(named: name)
                item.target = self
                gremlinsSubmenu.addItem(item)
            }

            iGremlin.submenu = gremlinsSubmenu
        }
    }

    func makeJointsSubmenu(_ menu: NSMenu, _ iJoint: NSMenuItem?, _ event: NSEvent) {
        if let iJoint {
            iJoint.target = self
            menu.addItem(iJoint)

            let jointsSubmenu = NSMenu()

            PhysicsJointType.allCases.forEach { jointType in
                let item = NSMenuItem(
                    title: jointType.rawValue, action: #selector(selectPhysicsJoint), keyEquivalent: ""
                )

                item.representedObject = ContextMenuArguments(stringArgument: jointType.rawValue, event: event)
                item.target = self
                jointsSubmenu.addItem(item)
            }

            iJoint.submenu = jointsSubmenu
        }
    }

    func makeVerticesSubmenu(_ menu: NSMenu, _ iVertex: NSMenuItem?, _ event: NSEvent) {
        if let iVertex {
            iVertex.target = self
            iVertex.representedObject = ContextMenuArguments(event: event)
            menu.addItem(iVertex)
        }
    }
}

extension GameScene {

    @objc func clickToPlaceVertex(_ sender: Any?) {
        let menuItem = Utility.forceCast(sender, to: NSMenuItem.self)
        let arguments = Utility.forceCast(menuItem.representedObject, to: ContextMenuArguments.self)
        let event = Utility.forceCast(arguments.event, to: NSEvent.self)

        gameController.commandSelection.clickToPlace = .vertex
        mouseState = .mouseDown
        commonMouseUp(with: event)
    }

    @objc func selectGremlinTexture(_ sender: Any?) {
        let menuItem = Utility.forceCast(sender, to: NSMenuItem.self)
        let arguments = Utility.forceCast(menuItem.representedObject, to: ContextMenuArguments.self)
        let event = Utility.forceCast(arguments.event, to: NSEvent.self)
        let textureName = Utility.forceCast(arguments.stringArgument, to: String.self)

        gameController.commandSelection.selectedGremlinTexture = textureName
        gameController.commandSelection.clickToPlace = .gremlin

        mouseState = .mouseDown
        commonMouseUp(with: event)
    }

    @objc func selectPhysicsField(_ sender: Any?) {
        let menuItem = Utility.forceCast(sender, to: NSMenuItem.self)
        let arguments = Utility.forceCast(menuItem.representedObject, to: ContextMenuArguments.self)
        let fieldName = Utility.forceCast(arguments.stringArgument, to: String.self)
        let event = Utility.forceCast(arguments.event, to: NSEvent.self)

        gameController.commandSelection.selectedPhysicsFieldType = fieldName
        gameController.commandSelection.clickToPlace = .field

        mouseState = .mouseDown
        commonMouseUp(with: event)
    }

    @objc func selectPhysicsJoint(_ sender: Any?) {
        let menuItem = Utility.forceCast(sender, to: NSMenuItem.self)
        let arguments = Utility.forceCast(menuItem.representedObject, to: ContextMenuArguments.self)
        let jointName = Utility.forceCast(arguments.stringArgument, to: String.self)
        let event = Utility.forceCast(arguments.event, to: NSEvent.self)

        gameController.commandSelection.selectedPhysicsJointType = jointName
        gameController.commandSelection.clickToPlace = .joint

        mouseState = .mouseDown
        commonMouseUp(with: event)
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
            iVertex = NSMenuItem(title: "Place Vertex", action: #selector(clickToPlaceVertex), keyEquivalent: "")

        case .entity:
            iField = NSMenuItem(title: "Attach Field", action: nil, keyEquivalent: "")
            iJoint = NSMenuItem(title: "Attach Joint", action: nil, keyEquivalent: "")

        default:
            fatalError()
        }

        makeFieldsSubmenu(menu, iField, event)
        makeGremlinsSubmenu(menu, iGremlin, event)
        makeJointsSubmenu(menu, iJoint, event)
        makeVerticesSubmenu(menu, iVertex, event)

        NSMenu.popUpContextMenu(menu, with: event, for: self.view!)
    }

}
