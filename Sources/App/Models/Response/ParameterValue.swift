import Foundation

enum ParameterValue: Codable {
    case double(Double), string(String), bool(Bool)

    init(data: Data) throws {
        guard let string = String(data: data, encoding: .utf8) else {
            throw ParameterValueError.unknownValue
        }

        if let bool = Bool(string) {
            self = .bool(bool)
        } else if let double = Double(string) {
            self = .double(double)
        } else {
            self = .string(string)
        }
    }

    init(from decoder: Decoder) throws {
        if let double = try? decoder.singleValueContainer().decode(Double.self) {
            self = .double(double)
        } else if let bool = try? decoder.singleValueContainer().decode(Bool.self) {
            self = .bool(bool)
        } else if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
        } else {
            throw ParameterValueError.unknownValue
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
            case let .double(value): try container.encode(value)
            case let .bool(value): try container.encode(value)
            case let .string(value): try container.encode(value)
        }
    }


    enum ParameterValueError: Error {
        case unknownValue
    }
}

extension ParameterValue: Equatable {}
