// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class EntityActionsPublisher: ObservableObject {
    @Published var actionTokens = [ActionTokenContainer]()

    init() {
        makeTestTokensArray()
    }

    func makeTestTokensArray() {
        actionTokens = (0..<5).map { _ in ActionTokenContainer.randomToken() }
    }
}
