import Foundation

struct Comparator<Type: Comparable> {
    static func compare(lhs: Type, operator: Operator, rhs: Type) -> Bool {
        switch `operator` {
            case .equal: return lhs == rhs
            case .notEqual: return lhs != rhs
            case .larger: return lhs > rhs
            case .smaller: return lhs < rhs
        }
    }
}

extension Comparator where Type == String {
    static func compare(lhs: Type, operator: Operator, rhs: Type) -> Bool {
        switch `operator` {
            case .equal: return lhs == rhs
            case .notEqual: return lhs != rhs
            case .larger: return false
            case .smaller: return false
        }
    }
}
