// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

enum Utility {
    static func positionString(_ position: CGPoint, _ decimals: Int = 2) -> String {
        let vx = String(format: "%.\(decimals)f", position.x)
        let vy = String(format: "%.\(decimals)f", position.y)

        return "(\(vx), \(vy))"
    }

    static func vectorString(_ vector: CGVector, _ decimals: Int = 2) -> String {
        let vx = String(format: "%.\(decimals)f", vector.dx)
        let vy = String(format: "%.\(decimals)f", vector.dy)

        return "(\(vx), \(vy))"
    }
}

// swiftlint:disable nesting
extension Utility {
    protocol RandomizableRange {
        associatedtype Bound: BinaryFloatingPoint where Bound.RawSignificand: FixedWidthInteger
        func contains(_ element: Bound) -> Bool
        var lowerBound: Bound { get }
        var upperBound: Bound { get }
    }
}
// swiftlint:enable nesting

extension Range: Utility.RandomizableRange
    where Bound: BinaryFloatingPoint, Bound.RawSignificand: FixedWidthInteger {}

extension ClosedRange: Utility.RandomizableRange
    where Bound: BinaryFloatingPoint, Bound.RawSignificand: FixedWidthInteger {}

extension Utility {
    static func randomPair<T: RandomizableRange>(in range: T, bRange: T? = nil) -> (T.Bound, T.Bound) {
        let a = T.Bound.random(in: range.lowerBound..<range.upperBound)
        let bRange = bRange ?? range
        let b = T.Bound.random(in: bRange.lowerBound..<bRange.upperBound)

        return (a, b)
    }
}

extension Utility {
    static func forceCast<T>(_ object: Any?, to expectedType: T.Type) -> T {
        assert(object is T, "You said this couldn't happen")
        guard let forced = object as? T else {
            fatalError("The gods said this couldn't happen")
        }

        return forced
    }
}
