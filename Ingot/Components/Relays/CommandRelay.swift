// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class CommandRelay: ObservableObject {

    enum ActiveTab {
        case physicsAction, physicsEntity, physicsWorld, shapeLab, spaceAction
    }

    @Published var actionsSpeed: CGFloat = 1
    @Published var activeTab = ActiveTab.physicsWorld
    @Published var playActions: Bool = false
    @Published var playPhysics: Bool = false
}
