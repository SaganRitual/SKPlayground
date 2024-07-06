// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsBodySlidersView: View {
    @ObservedObject var physicsBodyRelay: PhysicsBodyRelay

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SKPSliderWithRelay<SKPhysicsBody, CGFloat, Text, Text>(
                $physicsBodyRelay.charge,
                fieldKeypath: \.charge,
                range: -2...2,
                scalarView: Text(String(format: "%.2f", physicsBodyRelay.charge)),
                titleView: Text("Charge")
            )
            .padding(.top)

            SKPSliderWithRelay<SKPhysicsBody, CGFloat, Text, Text>(
                $physicsBodyRelay.friction,
                fieldKeypath: \.friction,
                range: -2...25,
                scalarView: Text(String(format: "%.2f", physicsBodyRelay.friction)),
                titleView: Text("Friction")
            )

            SKPSliderWithRelay<SKPhysicsBody, CGFloat, Text, Text>(
                $physicsBodyRelay.mass,
                fieldKeypath: \.mass,
                range: 0...10,
                scalarView: Text(String(format: "%.2f", physicsBodyRelay.mass)),
                titleView: Text("Mass")
            )

            SKPSliderWithRelay<SKPhysicsBody, CGFloat, Text, Text>(
                $physicsBodyRelay.restitution,
                fieldKeypath: \.restitution,
                range: -2...2,
                scalarView: Text(String(format: "%.2f", physicsBodyRelay.restitution)),
                titleView: Text("Restitution")
            )

            Text("Damping")
                .underline()
                .padding(.leading)
                .padding(.top, 30)

            SKPSliderWithRelay<SKPhysicsBody, CGFloat, Text, Text>(
                $physicsBodyRelay.angularDamping,
                fieldKeypath: \.angularDamping,
                range: -2...2,
                scalarView: Text(String(format: "%.2f", physicsBodyRelay.angularDamping)),
                titleView: Text("Angular")
            )

            SKPSliderWithRelay<SKPhysicsBody, CGFloat, Text, Text>(
                $physicsBodyRelay.linearDamping,
                fieldKeypath: \.linearDamping,
                range: -2...2,
                scalarView: Text(String(format: "%.2f", physicsBodyRelay.linearDamping)),
                titleView: Text("Linear")
            )
        }
    }
}

#Preview {
    PhysicsBodySlidersView(physicsBodyRelay: PhysicsBodyRelay())
}
