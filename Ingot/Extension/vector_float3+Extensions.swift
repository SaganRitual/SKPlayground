// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

extension vector_float3 {
    init(_ cgVector: CGVector) {
        self.init(x: Float(cgVector.dx), y: Float(cgVector.dy), z: 0)
    }
}
