// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class UserShape {
    let uuid = UUID()
    var name: String
    var open: Bool
    var vertices: [Vertex]

    init(_ name: String, _ vertices: [Vertex], _ open: Bool) {
        self.name = name
        self.open = open
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

    private func makeUniqueName(_ shapeSet: [UserShape], whichShape: WhichShape, open: Bool) -> String {
        let openClosed: String = open ? "Open" : "Closed"
        let prefix: String
        switch whichShape {
        case .edge:
            prefix = "\(openClosed) Edge"
        case .path:
            prefix = "\(openClosed) Path"
        case .region:
            prefix = "Region"
        }

        for ix in shapeSet.count... {
            let trialName = "\(prefix) \(ix)"
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

    func newShape(_ which: WhichShape, _ vertices: Set<Vertex>, _ open: Bool) -> String {
//        let orderedVertices = Array(vertices).sorted { $0.selectionOrder < $1.selectionOrder }
//
//        let name = makeUniqueName(shapeSet(for: which), whichShape: which, open: open)
//        let shape = UserShape(name, orderedVertices, open)
//
//        switch which {
//        case .edge:
//            edges.append(shape)
//        case .path:
//            paths.append(shape)
//        case .region:
//            regions.append(shape)
//        }
//
//        return name
        return ""
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
