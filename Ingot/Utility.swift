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

extension Utility {
    protocol RandomizableRange {
        associatedtype Bound: BinaryFloatingPoint where Bound.RawSignificand: FixedWidthInteger
        func contains(_ element: Bound) -> Bool
        var lowerBound: Bound { get }
        var upperBound: Bound { get }
    }
}

extension Range: Utility.RandomizableRange where Bound: BinaryFloatingPoint, Bound.RawSignificand: FixedWidthInteger {}
extension ClosedRange: Utility.RandomizableRange where Bound: BinaryFloatingPoint, Bound.RawSignificand: FixedWidthInteger {}

extension Utility {
    static func randomPair<T: RandomizableRange>(in range: T, bRange: T? = nil) -> (T.Bound, T.Bound) {
        let a = T.Bound.random(in: range.lowerBound..<range.upperBound)
        let bRange = bRange ?? range
        let b = T.Bound.random(in: bRange.lowerBound..<bRange.upperBound)

        return (a, b)
    }
}
