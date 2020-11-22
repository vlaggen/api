import Vapor
import Fluent

final class UserDatabaseModel: Model {
    static let schema = "user"

    struct FieldKeys {
        static var email: FieldKey { "email" }
        static var password: FieldKey { "password" }

        static var firstName: FieldKey { "first_name" }

        static var createdAt: FieldKey { "created_at" }
        static var updatedAt: FieldKey { "updated_at" }
    }

    @ID() var id: UUID?
    @Field(key: FieldKeys.email) var email: String
    @Field(key: FieldKeys.password) var password: String

    @OptionalField(key: FieldKeys.firstName) var firstName: String?

    @Timestamp(key: FieldKeys.createdAt, on: .create) var createdAt: Date?
    @Timestamp(key: FieldKeys.updatedAt, on: .update) var updatedAt: Date?

    init() {}

    init(id: UUID? = nil,
         email: String,
         password: String,
         firstName: String?
    ) {
        self.id = id
        self.email = email
        self.password = password
        self.firstName = firstName
    }
}
