// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct FollowPathActionTokenView: View, ActionTokenViewProtocol {
    @EnvironmentObject var shapeLab: ShapeLab

    let duration: Double
    let path: [CGPoint]?
    let pathId: UUID?
    let selected: Bool

    init(duration: Double, path: [CGPoint], selected: Bool) {
        self.duration = duration
        self.path = path
        self.pathId = nil
        self.selected = selected
    }

    init(duration: Double, pathId: UUID, selected: Bool) {
        self.duration = duration
        self.path = nil
        self.pathId = pathId
        self.selected = selected
    }

    var description: String {
        if pathId == nil {
            return "\(self.path!.first!)...\(self.path!.last!)"
        } else {
            return shapeLab.paths.first(where: { $0.uuid == pathId! })!.name
        }
    }

    var body: some View {
        VStack(alignment: .center) {
            Text("Follow path \(description)")
            Text(String(format: "t = %.1fs", duration))
        }
        .actionTokenStyle(selected)
    }
}
