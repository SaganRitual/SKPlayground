// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class RelayManager: ObservableObject {
    @Published var gameSceneRelay = GameSceneRelay()
}
