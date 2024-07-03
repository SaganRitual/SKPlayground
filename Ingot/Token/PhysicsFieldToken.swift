// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

protocol PhysicsFieldTokenProtocol {
}

struct PhysicsFieldTokenContainer: Identifiable {
    let id = UUID()
    let name: String
    let token: any PhysicsFieldTokenProtocol

    let falloff: CGFloat
    let isEnabled: Bool
    let isExclusive: Bool
    let maskCategories: UInt32
    let minimumRadius: CGFloat
    let region: SKRegion?
    let strength: CGFloat
}

struct DragFieldToken: PhysicsFieldTokenProtocol {

}

struct ElectricFieldToken: PhysicsFieldTokenProtocol {

}

struct LinearGravityFieldToken: PhysicsFieldTokenProtocol {

}

struct MagneticFieldToken: PhysicsFieldTokenProtocol {

}

struct NoiseFieldToken: PhysicsFieldTokenProtocol {
    let animationSpeed: CGFloat
    let smoothness: CGFloat
}

struct RadialGravityFieldToken: PhysicsFieldTokenProtocol {

}

struct SpringFieldToken: PhysicsFieldTokenProtocol {

}

struct TurbulenceFieldToken: PhysicsFieldTokenProtocol {
    let animationSpeed: CGFloat
    let smoothness: CGFloat
}

struct VelocityFieldToken: PhysicsFieldTokenProtocol {
    let direction: CGVector
}

struct VortexFieldToken: PhysicsFieldTokenProtocol {

}
