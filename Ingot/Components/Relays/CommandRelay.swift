// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class CommandRelay: ObservableObject {

    enum ActiveTab {
        case physicsAction, physicsEntity, physicsWorld, spaceAction
    }

    @Published var actionsSpeed: CGFloat = 1
    @Published var activeTab = ActiveTab.physicsWorld
    @Published var physicsSpeed: CGFloat = 1
    @Published var playActions: Bool = false
    @Published var playPhysics: Bool = false
}
