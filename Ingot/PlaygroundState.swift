// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SwiftUI

enum ClickToCreate: String, RawRepresentable, CaseIterable, Identifiable {
    var id: String { self.rawValue }

    case gremlin = "Gremlin", physics = "Physics", waypoint = "Waypoint"
}

enum PlaceablePhysics: String, RawRepresentable, CaseIterable, Identifiable {
    var id: String { self.rawValue }

    case edge = "Edge", field = "Field", joint = "Joint"
}

enum SelectionState {
    case many, none, one
}

protocol HasPhysicsBody {
    var area: CGFloat { get }
    var density: CGFloat { get }
    var friction: CGFloat { get }
    var mass: CGFloat { get }
    var restitution: CGFloat { get }
    var angularDamping: CGFloat { get }
    var linearDamping: CGFloat { get }

    var dynamism: Bool { get }
    var gravitism: Bool { get }
    var rotatism: Bool { get }
}

class PhysicsBodyHaver: HasPhysicsBody, ObservableObject {
    @Published var area: CGFloat = .random(in: 0...10)
    @Published var density: CGFloat = .random(in: 0...10)
    @Published var friction: CGFloat = .random(in: 0...10)
    @Published var mass: CGFloat = .random(in: 0...10)
    @Published var restitution: CGFloat = .random(in: 0...10)
    @Published var angularDamping: CGFloat = .random(in: 0...10)
    @Published var linearDamping: CGFloat = .random(in: 0...10)

    @Published var dynamism: Bool = false
    @Published var gravitism: Bool = false
    @Published var rotatism: Bool = false
}

class PlaygroundState: ObservableObject {
    @Published var activeActionTokens = [ActionTokenContainer]()
    @Published var assignSpaceActions: Bool = false
    @Published var cameraPosition: CGPoint = .zero
    @Published var cameraScale: CGFloat = 1
    @Published var clickToCreate: ClickToCreate = .gremlin
    @Published var placePhysics: PlaceablePhysics = .field
    @Published var mousePosition: CGPoint = .zero
    @Published var selectionState: SelectionState = .none
    @Published var viewSize: CGSize = .zero
//
//    func setSelectionState(_ selectedEntities: Set<GameEntity>?) {
//        let count = selectedEntities?.count ?? 0
//        switch count {
//        case 0: selectionState = .none
//        case 1: selectionState = .one
//        default: selectionState = .many
//        }
//    }

    @Published var physicsBodyHaver = PhysicsBodyHaver()

    init() {
        makeTestTokensArray()
    }

    func makeTestTokensArray() {
        activeActionTokens = (0..<5).map { _ in ActionTokenContainer.randomToken() }
    }
}
