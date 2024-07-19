// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class ActionsManager: ObservableObject {
    @Published var actionTokens = [ActionToken]()
    @Published var selectedActionToken: ActionToken?
}

final class SelectedActionsManager: ObservableObject {
    @Published var selected: ActionsManager?

    init(_ selected: ActionsManager?) {
        self.selected = selected
    }
}
