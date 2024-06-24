// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

enum PlaceablePhysics: String, RawRepresentable, CaseIterable, Identifiable {
    var id: String { self.rawValue }

    case edge = "Edge", field = "Field", joint = "Joint"
}

enum PhysicsFieldType: String, CaseIterable, Identifiable, RawRepresentable {
    var id: String { self.rawValue }

    case drag = "Drag", electric = "Electric", linearGravity = "Linear Gravity"
    case magnetic = "Magnetic", noise = "Noise", radialGravity = "Radial Gravity"
    case spring = "Spring", turbulence = "Turbulence", velocity = "Velocity"
    case vortex = "Vortex"
}

struct PhysicsFieldView: View {
    @EnvironmentObject var playgroundState: PlaygroundState

    var body: some View {
        VStack {
            switch playgroundState.selectedPhysicsField.fieldType {
            case .drag:
                EmptyView()
                
            case .electric:
                EmptyView()
                
            case .linearGravity:
                EmptyView()
                
            case .magnetic:
                EmptyView()
                
            case .noise:
                EmptyView()
                
            case .radialGravity:
                EmptyView()
                
            case .spring:
                EmptyView()
                
            case .turbulence:
                EmptyView()
                
            case .velocity:
                EmptyView()
                
            case .vortex:
                EmptyView()
            }
        }
    }
}

#Preview {
    PhysicsFieldView()
        .environmentObject(PlaygroundState())
}
