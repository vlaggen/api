import Vapor
import Fluent

final class ParameterDatabaseModel: Model {
    static let schema = "parameter"

    struct FieldKeys {
        static var key: FieldKey { "key" }
        static var description: FieldKey { "description" }
        static var standard: FieldKey { "standard" }

        static var createdAt: FieldKey { "created_at" }
        static var updatedAt: FieldKey { "updated_at" }
    }

    @ID() var id: UUID?
    @Field(key: FieldKeys.key) var key: String
    @Field(key: FieldKeys.description) var description: String
    @Field(key: FieldKeys.standard) var standard: Data

    @Timestamp(key: FieldKeys.createdAt, on: .create) var createdAt: Date?
    @Timestamp(key: FieldKeys.updatedAt, on: .update) var updatedAt: Date?

    init() {}

    init(id: UUID? = nil,
         key: String,
         description: String,
         standard: Data
    ) {
        self.id = id
        self.key = key
        self.description = description
        self.standard = standard
    }
}
