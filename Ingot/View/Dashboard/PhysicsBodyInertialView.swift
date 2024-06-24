// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsBodyInertialView: View {
    @EnvironmentObject var playgroundState: PlaygroundState

    func makeScalarView(_ value: CGFloat) -> some View {
        Text(String(format: "%.2f", value))
    }

    var body: some View {
        VStack {
            PhysicsBodyTogglesView()
                .padding(.bottom)

            HStack {
                VStack {
                    Text("Body")
                        .underline()
                    
                    BasicScalarSlider(
                        scalar: $playgroundState.physicsBodyHaver.density,
                        scalarView: Text(String(format: "%.1f", playgroundState.physicsBodyHaver.density)),
                        title: Text("Density"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )
                    
                    BasicScalarSlider(
                        scalar: $playgroundState.physicsBodyHaver.mass,
                        scalarView: Text(String(format: "%.1f", playgroundState.physicsBodyHaver.mass)),
                        title: Text("Mass"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )
                }
                
                VStack {
                    Text("Damping")
                        .underline()
                    
                    BasicScalarSlider(
                        scalar: $playgroundState.physicsBodyHaver.angularDamping,
                        scalarView: Text(String(format: "%.1f", playgroundState.physicsBodyHaver.angularDamping)),
                        title: Text("Angular"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )
                    
                    BasicScalarSlider(
                        scalar: $playgroundState.physicsBodyHaver.linearDamping,
                        scalarView: Text(String(format: "%.1f", playgroundState.physicsBodyHaver.linearDamping)),
                        title: Text("Linear"),
                        minLabel: "0", maxLabel: "10", range: 0...10
                    )
                }
            }
        }
    }
}

#Preview {
    PhysicsBodyInertialView()
        .environmentObject(PlaygroundState())
}
