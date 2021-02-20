import Foundation

struct Comparator<Type: Comparable> {
    static func compare(lhs: Type, operator: Operator, rhs: Type) -> Bool {
        switch `operator` {
            case .equal: return lhs == rhs
            case .notEqual: return lhs != rhs
            case .greater: return lhs > rhs
            case .less: return lhs < rhs
        }
    }
}

extension Comparator where Type == String {
    static func compare(lhs: Type, operator: Operator, rhs: Type) -> Bool {
        switch `operator` {
            case .equal: return lhs == rhs
            case .notEqual: return lhs != rhs
            case .greater, .less: return false
        }
    }
}

extension Comparator where Type == Bool {
    static func compare(lhs: Type, operator: Operator, rhs: Type) -> Bool {
        switch `operator` {
            case .equal: return lhs == rhs
            case .notEqual: return lhs != rhs
            case .greater, .less: return false
        }
    }
}

extension Bool: Comparable {
    public static func < (lhs: Bool, rhs: Bool) -> Bool {
        return false
    }
}
