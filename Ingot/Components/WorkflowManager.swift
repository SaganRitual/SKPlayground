// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class WorkflowManager {

    enum ClickToPlace: String, RawRepresentable, CaseIterable, Identifiable {
        var id: String { self.rawValue }

        case field = "Field", gremlin = "Gremlin", joint = "Joint", vertex = "Vertex"
    }

    private(set) var avatarName = ContextMenuManager.avatarNames[0]
    private(set) var clickToPlace = ClickToPlace.gremlin
    private(set) var fieldType = PhysicsFieldType.drag
    private(set) var jointType = PhysicsJointType.fixed

    func placeField(_ fieldType: PhysicsFieldType) {
        self.clickToPlace = .field
        self.fieldType = fieldType
    }

    func placeGremlin(_ textureName: String) {
        self.clickToPlace = .gremlin
        self.avatarName = textureName
    }

    func placeJoint(_ jointType: PhysicsJointType) {
        self.clickToPlace = .joint
        self.jointType = jointType
    }

    func placeVertex() {
        self.clickToPlace = .vertex
    }
}
