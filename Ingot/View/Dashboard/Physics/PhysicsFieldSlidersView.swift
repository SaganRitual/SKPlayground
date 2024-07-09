// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsFieldSlidersView: View {
    @ObservedObject var physicsFieldRelay: PhysicsFieldRelay

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SKPSliderWithRelay<SKFieldNode, Float, Text, Text>(
                $physicsFieldRelay.animationSpeed,
                fieldKeypath: \.animationSpeed,
                range: 0...10,
                scalarView: Text(String(format: "%.2f", physicsFieldRelay.animationSpeed)),
                titleView: Text("Animation Speed")
            )
            .padding(.top)

            SKPSliderWithRelay<SKFieldNode,Float,Text, Text>(
                $physicsFieldRelay.falloff,
                fieldKeypath: \.falloff,
                range: 0...10,
                scalarView: Text(String(format: "%.2f", physicsFieldRelay.falloff)),
                titleView: Text("Falloff")
            )

            SKPSliderWithRelay<SKFieldNode,Float,Text, Text>(
                $physicsFieldRelay.minimumRadius,
                fieldKeypath: \.minimumRadius,
                range: 0...100,
                scalarView: Text(String(format: "%.2f", physicsFieldRelay.minimumRadius)),
                titleView: Text("Minimum Radius")
            )

            SKPSliderWithRelay<SKFieldNode,Float,Text, Text>(
                $physicsFieldRelay.smoothness,
                fieldKeypath: \.smoothness,
                range: 0...10,
                scalarView: Text(String(format: "%.2f", physicsFieldRelay.smoothness)),
                titleView: Text("Smoothness")
            )

            SKPSliderWithRelay<SKFieldNode,Float,Text, Text>(
                $physicsFieldRelay.strength,
                fieldKeypath: \.strength,
                range: 0...100,
                scalarView: Text(String(format: "%.2f", physicsFieldRelay.strength)),
                titleView: Text("Strength")
            )
        }
    }
}

#Preview {
    PhysicsFieldSlidersView(physicsFieldRelay: PhysicsFieldRelay())
}
