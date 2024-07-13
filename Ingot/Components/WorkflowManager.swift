// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class WorkflowManager {

    enum ClickToPlace: String, RawRepresentable, CaseIterable, Identifiable {
        var id: String { self.rawValue }

        case field = "Field", gremlin = "Gremlin", joint = "Joint", vertex = "Vertex"
    }

    enum Workflow {
        case assigningSpaceActions, idle
        case placingEdgeVertices, placingPhysicsJoint, placingRegionVertices, placingWaypoints
    }

    private(set) var avatarName = ContextMenuManager.avatarNames[0]
    private(set) var clickToPlace = ClickToPlace.gremlin
    private(set) var currentWorkflow = Workflow.idle
    private(set) var fieldType = PhysicsFieldType.drag
    private(set) var jointType = PhysicsJointType.fixed

    func assignSpaceActions() {
        self.currentWorkflow = .assigningSpaceActions
    }

    func beginEdge() {
        self.clickToPlace = .vertex
        self.currentWorkflow = .placingEdgeVertices
    }

    func beginPath() {
        self.clickToPlace = .vertex
        self.currentWorkflow = .placingWaypoints
    }

    func beginRegion() {
        self.clickToPlace = .vertex
        self.currentWorkflow = .placingRegionVertices
    }

    func placeField(_ fieldType: PhysicsFieldType) {
        self.clickToPlace = .field
        self.currentWorkflow = .idle
        self.fieldType = fieldType
    }

    func placeGremlin(_ textureName: String) {
        self.clickToPlace = .gremlin
        self.currentWorkflow = .idle
        self.avatarName = textureName
    }

    func placeJoint(_ jointType: PhysicsJointType) {
        self.clickToPlace = .joint
        self.currentWorkflow = .placingPhysicsJoint
        self.jointType = jointType
    }

    func placeVertex() {
        self.clickToPlace = .vertex
        self.currentWorkflow = .idle
    }
}
