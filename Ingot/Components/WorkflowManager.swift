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

    weak var workflowRelay: WorkflowRelay!

    func assignSpaceActions() {
        workflowRelay.currentWorkflow = .assigningSpaceActions
    }

    func beginEdge() {
        workflowRelay.clickToPlace = .vertex
        workflowRelay.currentWorkflow = .placingEdgeVertices
    }

    func beginPath() {
        workflowRelay.clickToPlace = .vertex
        workflowRelay.currentWorkflow = .placingWaypoints
    }

    func beginRegion() {
        workflowRelay.clickToPlace = .vertex
        workflowRelay.currentWorkflow = .placingRegionVertices
    }

    func placeField(_ fieldType: PhysicsFieldType) {
        workflowRelay.clickToPlace = .field
        workflowRelay.currentWorkflow = .idle
        workflowRelay.fieldType = fieldType
    }

    func placeGremlin(_ textureName: String) {
        workflowRelay.clickToPlace = .gremlin
        workflowRelay.currentWorkflow = .idle
        workflowRelay.avatarName = textureName
    }

    func placeJoint(_ jointType: PhysicsJointType) {
        workflowRelay.clickToPlace = .joint
        workflowRelay.currentWorkflow = .placingPhysicsJoint
        workflowRelay.jointType = jointType
    }

    func placeVertex() {
        workflowRelay.clickToPlace = .vertex
        workflowRelay.currentWorkflow = .idle
    }
}
