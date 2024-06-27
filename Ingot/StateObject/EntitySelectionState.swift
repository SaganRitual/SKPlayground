// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

enum SelectionState {
    case many, none, one
}

final class EntitySelectionState: ObservableObject {
    @Published var selectionState: SelectionState = .none

    func setSelectionState(_ selectedEntities: Set<GameEntity>?) {
        let count = selectedEntities?.count ?? 0
        switch count {
        case 0: selectionState = .none
        case 1: selectionState = .one
        default: selectionState = .many
        }
    }
}
