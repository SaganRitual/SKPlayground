// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class UserShape {
    let uuid = UUID()
    var name: String
    var vertices: [Vertex]

    init(_ name: String, _ vertices: [Vertex]) {
        self.name = name
        self.vertices = vertices
    }
}

extension UserShape: Equatable, Hashable, Identifiable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    static func == (lhs: UserShape, rhs: UserShape) -> Bool {
        return lhs === rhs
    }
}

final class ShapeLab: ObservableObject {
    enum WhichShape { case edge, path, region }

    @Published var edges = [UserShape]()
    @Published var paths = [UserShape]()
    @Published var regions = [UserShape]()

    private func makeUniqueName(_ shapeSet: [UserShape]) -> String {
        for ix in shapeSet.count... {
            let trialName = "Shape \(ix)"
            if !shapeSet.contains(where: { $0.name == trialName }) {
                return trialName
            }
        }

        fatalError("Did you create billions of shapes or what?")
    }

    func shapeSet(for which: WhichShape) -> [UserShape] {
        switch which {
        case .edge:
            return edges
        case .path:
            return paths
        case .region:
            return regions
        }
    }

    func newShape(_ which: WhichShape, _ vertices: Set<Vertex>) -> String {
        let orderedVertices = Array(vertices).sorted { $0.selectionOrder < $1.selectionOrder }

        let name = makeUniqueName(shapeSet(for: which))
        let shape = UserShape(name, orderedVertices)

        switch which {
        case .edge:
            edges.append(shape)
        case .path:
            paths.append(shape)
        case .region:
            regions.append(shape)
        }

        return name
    }

    func renameShape(_ which: WhichShape, currentName: String, newName: String) -> Int? {
        var shapeSet: [UserShape]

        switch which {
        case .edge:
            shapeSet = edges
        case .path:
            shapeSet = paths
        case .region:
            shapeSet = regions
        }

        if let index = shapeSet.firstIndex(where: { $0.name == newName }) {
            return index
        }

        if let index = shapeSet.firstIndex(where: { $0.name == currentName }) {
            shapeSet[index].name = newName
        }

        return nil
    }
}
