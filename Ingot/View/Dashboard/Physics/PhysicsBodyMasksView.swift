// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

final class PhysicsMaskNames: ObservableObject {
    @Published var names: [String] = (0..<32).map { "Mask \($0)" }

    func renameMask(currentName: String, newName: String) -> Int? {
        if let index = names.firstIndex(of: newName) {
            return index
        }

        if let index = names.firstIndex(of: currentName) {
            names[index] = newName
        }

        return nil
    }
}

struct PhysicsBodyMasksView: View {
    @EnvironmentObject var gameController: GameController

    @ObservedObject var physicsMaskNames: PhysicsMaskNames

    @State private var applyFields = Set<Int>()
    @State private var collideWith = Set<Int>()
    @State private var reportContactWith = Set<Int>()

    var body: some View {
        VStack {
            SKPMaskSelector<SKPhysicsBody>(
                $applyFields,
                fieldKeypath: \.fieldBitMask,
                label: Text("Apply Fields"),
                options: physicsMaskNames.names
            )

            SKPMaskSelector<SKPhysicsBody>(
                $collideWith,
                fieldKeypath: \.collisionBitMask,
                label: Text("Collide With"),
                options: physicsMaskNames.names
            )

            SKPMaskSelector<SKPhysicsBody>(
                $reportContactWith,
                fieldKeypath: \.contactTestBitMask,
                label: Text("Report Contact With"),
                options: physicsMaskNames.names
            )
        }
        .padding([.top, .horizontal])
    }
}

#Preview {
    PhysicsBodyMasksView(physicsMaskNames: PhysicsMaskNames())
        .environmentObject(GameController())
}
