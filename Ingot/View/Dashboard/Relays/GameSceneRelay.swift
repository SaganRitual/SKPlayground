// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class GameSceneRelay: ObservableObject {
    @Published var cameraPosition: CGPoint = .zero
    @Published var cameraScale: CGFloat = 1
    @Published var mousePosition: CGPoint = .zero
    @Published var viewSize: CGSize = .zero
}
