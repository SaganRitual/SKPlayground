// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SwiftUI

enum ClickToPlace: String, RawRepresentable, CaseIterable, Identifiable {
    var id: String { self.rawValue }

    case field = "Field", gremlin = "Gremlin", joint = "Joint", vertex = "Vertex", waypoint = "Waypoint"
}

enum SelectionState {
    case many, none, one
}

class PlaygroundState: ObservableObject {
    @Published var activeActionTokens = [ActionTokenContainer]()
    @Published var assignSpaceActions: Bool = false
    @Published var cameraPosition: CGPoint = .zero
    @Published var cameraScale: CGFloat = 1
    @Published var clickToPlace: ClickToPlace = .gremlin
    @Published var placePhysics: PlaceablePhysics = .field
    @Published var mousePosition: CGPoint = .zero
    @Published var selectionState: SelectionState = .none
    @Published var selectedPhysicsField: PhysicsField = PhysicsField()
    @Published var viewSize: CGSize = .zero

    func setSelectionState(_ selectedEntities: Set<GameEntity>?) {
        let count = selectedEntities?.count ?? 0
        switch count {
        case 0: selectionState = .none
        case 1: selectionState = .one
        default: selectionState = .many
        }
    }

    @Published var physicsBodyHaver = PhysicsBody()
    @Published var physicsCategories = Categories()
    @Published var physicsField = PhysicsField()
    @Published var selectedGremlinTexture = ""

    var gremlinImageNames = [String]()

    init() {
        makeTestTokensArray()
        gremlinImageNames = Self.loadSpriteTexturesFromBundle()
        selectedGremlinTexture = gremlinImageNames[0]
    }

    static func loadSpriteTexturesFromBundle() -> [String] {
        var imageNames = [String]()

        if let bundleURL = Bundle.main.url(forResource: "Sprites", withExtension: nil),
           let bundleContents = try? FileManager.default.contentsOfDirectory(at: bundleURL, includingPropertiesForKeys: nil, options: []) {

            imageNames = bundleContents
                .filter { $0.pathExtension == "png" } // Filter for PNGs
                .map { $0.deletingPathExtension().lastPathComponent } // Extract file names
        }

        return imageNames
    }

    func makeTestTokensArray() {
        activeActionTokens = (0..<5).map { _ in ActionTokenContainer.randomToken() }
    }
}
