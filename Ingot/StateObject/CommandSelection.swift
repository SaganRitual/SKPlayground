// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SwiftUI

enum ClickToPlace: String, RawRepresentable, CaseIterable, Identifiable {
    var id: String { self.rawValue }

    case field = "Field", gremlin = "Gremlin", joint = "Joint", vertex = "Vertex", waypoint = "Waypoint"
}

final class CommandSelection: ObservableObject {
    @Published var actionsSpeed: CGFloat = 1
    @Published var clickToPlace: ClickToPlace = .gremlin
    @Published var physicsSpeed: CGFloat = 1
    @Published var playActions: Bool = false
    @Published var playPhysics: Bool = false
    @Published var selectedGremlinTexture = ""

    var gremlinImageNames = [String]()

    init() {
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
}
