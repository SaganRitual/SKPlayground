// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class PhysicsFieldLab: ObservableObject {
    static var uniqueNameCounter = 1

    @Published var fields = [PhysicsFieldTokenContainer]()
}
