// We are a way for the cosmos to know itself. -- C. Sagan

import AppKit
import Foundation

final class ContextMenuManager {
    enum MenuType { case entity, scene }

    static let avatarNames = [
        "biclops",
        "bluethinglarge",
        "bluethingsmall",
        "claw",
        "cyclops",
        "emojer",
        "flapper",
        "grouch",
        "inkwell",
        "jumpywelder",
        "sleepyjumper",
        "triclops"
    ]

    weak var gameController: GameController!
    weak var gestureEventDispatcher: GestureEventDispatcher!
    weak var workflowManager: WorkflowManager!

    func showMenu(_ menuType: MenuType, _ gestureEvent: GestureEvent) {
        let menu = NSMenu()

        var iActions: NSMenuItem!
        var iField: NSMenuItem!
        var iFollow: NSMenuItem!
        var iGremlin: NSMenuItem!
        var iJoint: NSMenuItem!
        var iVertex: NSMenuItem!

        switch menuType {
        case .scene:
            iField = NSMenuItem(title: "Place Field", action: nil, keyEquivalent: "")
            iGremlin = NSMenuItem(title: "Place Gremlin", action: nil, keyEquivalent: "")
            iJoint = NSMenuItem(title: "Place Joint", action: nil, keyEquivalent: "")
            iVertex = NSMenuItem(title: "Place Vertex", action: #selector(clickToPlaceVertex), keyEquivalent: "")

        case .entity:
            iActions = NSMenuItem(title: "Assign Space Actions", action: #selector(readyForActions), keyEquivalent: "")
            iField = NSMenuItem(title: "Attach Field", action: nil, keyEquivalent: "")
            iFollow = NSMenuItem(title: "Create Path", action: #selector(clickToPlaceWaypoint), keyEquivalent: "")
            iJoint = NSMenuItem(title: "Attach Joint", action: nil, keyEquivalent: "")
        }

        makeActionsSubmenu(menu, iActions, gestureEvent)
        makeFieldsSubmenu(menu, iField, gestureEvent)
        makeGremlinsSubmenu(menu, iGremlin, gestureEvent)
        makeJointsSubmenu(menu, iJoint, gestureEvent)
        makeVerticesSubmenu(menu, iVertex, gestureEvent)
        makeWaypointsSubmenu(menu, iFollow, gestureEvent)

        let view = Utility.forceCast(gestureEvent.inputEvent.scene.view, to: NSView.self)
        let nsEvent = gestureEvent.inputEvent.nsEvent
        NSMenu.popUpContextMenu(menu, with: nsEvent, for: view)
    }
}

private extension ContextMenuManager {
    struct ContextMenuArguments {
        let gestureEvent: GestureEvent
        let stringArgument: String?

        init(gestureEvent: GestureEvent, stringArgument: String? = nil) {
            self.gestureEvent = gestureEvent
            self.stringArgument = stringArgument
        }
    }

    static func getGestureEvent(from sender: Any?) -> GestureEvent {
        let menuItem = Utility.forceCast(sender, to: NSMenuItem.self)
        let arguments = Utility.forceCast(menuItem.representedObject, to: ContextMenuArguments.self)
        let gestureEvent = Utility.forceCast(arguments.gestureEvent, to: GestureEvent.self)

        return gestureEvent
    }

    static func getLocation(from sender: Any?) -> CGPoint {
        return getGestureEvent(from: sender).inputEvent.location
    }

    static func getString(from sender: Any?) -> String {
        let menuItem = Utility.forceCast(sender, to: NSMenuItem.self)
        let arguments = Utility.forceCast(menuItem.representedObject, to: ContextMenuArguments.self)
        let stringArgument = Utility.forceCast(arguments.stringArgument, to: String.self)

        return stringArgument
    }

    static func makeLeftClickGestureEvent(fromRightClick sender: Any?) -> GestureEvent {
        let gestureEvent = getGestureEvent(from: sender)

        return GestureEvent(
            inputEvent: gestureEvent.inputEvent, newGestureState: .click, oldGestureState: gestureEvent.oldGestureState
        )
    }
}

private extension ContextMenuManager {

    @objc func clickToPlaceVertex(_ sender: Any?) {
        workflowManager.placeVertex()
        gestureEventDispatcher.gestureEvent(Self.makeLeftClickGestureEvent(fromRightClick: sender))
    }

    @objc func clickToPlaceWaypoint(_ sender: Any?) {
        workflowManager.beginPath()
        gestureEventDispatcher.gestureEvent(Self.makeLeftClickGestureEvent(fromRightClick: sender))
    }

    @objc func readyForActions(_ sender: Any?) {
//        workflowManager.assignSpaceActions()
//
//        let gestureEvent = Self.getGestureEvent(from: sender)
//        let entity = Utility.forceUnwrap(gestureEvent.inputEvent.getTopEntity())
//        gameController.setSpaceActionsMode(for: entity)
    }

    @objc func selectGremlinTexture(_ sender: Any?) {
        workflowManager.placeGremlin(Self.getString(from: sender))
        gestureEventDispatcher.gestureEvent(Self.makeLeftClickGestureEvent(fromRightClick: sender))
    }

    @objc func selectPhysicsField(_ sender: Any?) {
        let fieldName = Self.getString(from: sender)
        let fieldType = Utility.forceCast(PhysicsFieldType(rawValue: fieldName), to: PhysicsFieldType.self)
        workflowManager.placeField(fieldType)
        gestureEventDispatcher.gestureEvent(Self.makeLeftClickGestureEvent(fromRightClick: sender))
    }

    @objc func selectPhysicsJoint(_ sender: Any?) {
        let jointName = Self.getString(from: sender)
        let jointType = Utility.forceCast(PhysicsJointType(rawValue: jointName), to: PhysicsJointType.self)
        workflowManager.placeJoint(jointType)
        gestureEventDispatcher.gestureEvent(Self.makeLeftClickGestureEvent(fromRightClick: sender))
    }

}

private extension ContextMenuManager {
    func makeActionsSubmenu(_ menu: NSMenu, _ iActions: NSMenuItem?, _ gestureEvent: GestureEvent) {
        if let iActions {
            iActions.representedObject = ContextMenuArguments(gestureEvent: gestureEvent)
            iActions.target = self
            menu.addItem(iActions)
        }
    }

    func makeFieldsSubmenu(_ menu: NSMenu, _ iField: NSMenuItem?, _ gestureEvent: GestureEvent) {
        if let iField {
            iField.target = self
            menu.addItem(iField)

            let fieldsSubmenu = NSMenu()

            PhysicsFieldType.allCases.forEach { fieldType in
                let item = NSMenuItem(
                    title: fieldType.rawValue, action: #selector(selectPhysicsField), keyEquivalent: ""
                )

                item.representedObject = ContextMenuArguments(
                    gestureEvent: gestureEvent, stringArgument: fieldType.rawValue
                )

                item.target = self

                fieldsSubmenu.addItem(item)
            }

            iField.submenu = fieldsSubmenu
        }
    }

    func makeGremlinsSubmenu(_ menu: NSMenu, _ iGremlin: NSMenuItem?, _ gestureEvent: GestureEvent) {
        if let iGremlin {
            iGremlin.target = self
            menu.addItem(iGremlin)

            let gremlinsSubmenu = NSMenu()

            Self.avatarNames.forEach { name in
                let item = NSMenuItem(title: "", action: #selector(selectGremlinTexture), keyEquivalent: "")

                item.representedObject = ContextMenuArguments(
                    gestureEvent: gestureEvent, stringArgument: name
                )

                item.image = NSImage(named: name)
                item.target = self

                gremlinsSubmenu.addItem(item)
            }

            iGremlin.submenu = gremlinsSubmenu
        }
    }

    func makeJointsSubmenu(_ menu: NSMenu, _ iJoint: NSMenuItem?, _ gestureEvent: GestureEvent) {
        if let iJoint {
            iJoint.target = self
            menu.addItem(iJoint)

            let jointsSubmenu = NSMenu()

            PhysicsJointType.allCases.forEach { jointType in
                let item = NSMenuItem(
                    title: jointType.rawValue, action: #selector(selectPhysicsJoint), keyEquivalent: ""
                )

                item.representedObject = ContextMenuArguments(
                    gestureEvent: gestureEvent, stringArgument: jointType.rawValue
                )

                item.target = self
                jointsSubmenu.addItem(item)
            }

            iJoint.submenu = jointsSubmenu
        }
    }

    func makeVerticesSubmenu(_ menu: NSMenu, _ iVertex: NSMenuItem?, _ gestureEvent: GestureEvent) {
        if let iVertex {
            iVertex.representedObject = ContextMenuArguments(gestureEvent: gestureEvent)
            iVertex.target = self
            menu.addItem(iVertex)
        }
    }

    func makeWaypointsSubmenu(_ menu: NSMenu, _ iFollow: NSMenuItem?, _ gestureEvent: GestureEvent) {
        if let iFollow {
            iFollow.representedObject = ContextMenuArguments(gestureEvent: gestureEvent)
            iFollow.target = self
            menu.addItem(iFollow)
        }
    }
}
