import Vapor
import Fluent

final class RequirementDatabaseModel: Model {
    static let schema = "requirement"

    struct FieldKeys {
        static var when: FieldKey { "when" }
        static var `operator`: FieldKey { "operator" }
        static var then: FieldKey { "then" }

        static var createdAt: FieldKey { "created_at" }
        static var updatedAt: FieldKey { "updated_at" }
    }

    @ID() var id: UUID?
    @Field(key: FieldKeys.when) var when: String
    @Field(key: FieldKeys.operator) var `operator`: String
    @Field(key: FieldKeys.then) var then: String

    @Timestamp(key: FieldKeys.createdAt, on: .create) var createdAt: Date?
    @Timestamp(key: FieldKeys.updatedAt, on: .update) var updatedAt: Date?

    init() {}

    init(when: String,
         operator: String,
         then: String
    ) {
        self.when = when
        self.operator = `operator`
        self.then = then
    }
}
