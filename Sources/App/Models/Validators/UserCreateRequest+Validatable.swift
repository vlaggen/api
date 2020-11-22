import Vapor
import VlaggenNetworkModels

extension UserCreateRequest: Validatable {
    public static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: .count(9...))
    }
}
