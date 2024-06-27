// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SwiftUI

final class CommandSelection: ObservableObject {
    @Published var clickToPlace: ClickToPlace = .gremlin
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
