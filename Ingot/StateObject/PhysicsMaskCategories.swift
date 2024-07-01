// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class PhysicsMaskCategories: ObservableObject {
    @Published var names: [String] = (0..<32).map { "Category \($0)" }

    func renameCategory(currentName: String, newName: String) -> Int? {
        if let index = names.firstIndex(of: newName) {
            return index
        }

        if let index = names.firstIndex(of: currentName) {
            names[index] = newName
        }

        return nil
    }
}
