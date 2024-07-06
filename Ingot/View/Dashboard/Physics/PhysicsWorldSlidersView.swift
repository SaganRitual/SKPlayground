// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsWorldSlidersView: View {
    @ObservedObject var physicsWorldRelay: PhysicsWorldRelay

    @State private var xGravity = CGFloat.zero
    @State private var yGravity = CGFloat.zero

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SKPSlider(
                $xGravity,
                range: -25...25,
                scalarView: Text(String(format: "%.2f", xGravity)),
                titleView: Text("Gravity X")
            )
            .padding(.top)

            SKPSlider(
                $yGravity,
                range: -25...25,
                scalarView: Text(String(format: "%.2f", yGravity)),
                titleView: Text("Gravity Y")
            )
        }
    }
}

#Preview {
    PhysicsWorldSlidersView(physicsWorldRelay: PhysicsWorldRelay())
}
