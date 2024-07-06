// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsJointFixedView: View {
    @ObservedObject var relay: PhysicsJointFixedRelay

    var body: some View {
        PhysicsJointCommonView(relay: relay)
    }
}
