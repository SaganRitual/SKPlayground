// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

enum PhysicsObjectType {
    case body(PhysicsBodyRelay)
    case field(PhysicsFieldRelay)
    case jointFixed(PhysicsJointFixedRelay)
    case jointLimit(PhysicsJointLimitRelay)
    case jointPin(PhysicsJointPinRelay)
    case jointSliding(PhysicsJointSlidingRelay)
    case jointSpring(PhysicsJointSpringRelay)
    case world(PhysicsWorldRelay)
}

final class SelectedPhysicsRelay: ObservableObject {
    @Published var selected: PhysicsObjectType?

    init(_ selected: PhysicsObjectType?) {
        self.selected = selected
    }

    func setSelected(_ object: PhysicsObjectType) {
        self.selected = object
    }

    func clearSelection() {
        self.selected = nil
    }
}
