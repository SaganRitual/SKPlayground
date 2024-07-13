// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class SKPView: SKView {
    var trackingArea: NSTrackingArea?

    // Not sure why this is necessary for our game scene to get the scroll, but ok
    override func scrollWheel(with event: NSEvent) {
        scene?.scrollWheel(with: event)
    }

    override func updateTrackingAreas() {
        super.updateTrackingAreas()

        if let existingArea = trackingArea {
            removeTrackingArea(existingArea)
        }

        let options: NSTrackingArea.Options = [
            .mouseMoved,
            .activeInKeyWindow,
            .inVisibleRect
        ]

        trackingArea = NSTrackingArea(rect: bounds, options: options, owner: self, userInfo: nil)
        addTrackingArea(trackingArea!)
    }
}
