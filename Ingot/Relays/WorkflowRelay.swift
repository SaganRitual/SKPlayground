// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class WorkflowRelay: ObservableObject {
    @Published var avatarName = ContextMenuManager.avatarNames[0]
    @Published var clickToPlace = WorkflowManager.ClickToPlace.gremlin
    @Published var currentWorkflow = WorkflowManager.Workflow.idle
    @Published var fieldType = PhysicsFieldType.drag
    @Published var jointType = PhysicsJointType.fixed
}
