import Foundation
import Vapor

struct ParameterResponse: Codable {
    let key: String
    let value: ParameterValue
}

extension ParameterResponse: Content {}
extension ParameterResponse: Equatable {}
