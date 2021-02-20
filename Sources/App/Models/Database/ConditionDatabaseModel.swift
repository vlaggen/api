import Vapor
import Fluent

final class ConditionDatabaseModel: Model {
    static let schema = "condition"

    struct FieldKeys {
        static var title: FieldKey { "title" }

        static var createdAt: FieldKey { "created_at" }
        static var updatedAt: FieldKey { "updated_at" }
    }

    @ID() var id: UUID?
    @Field(key: FieldKeys.title) var title: String

    @Siblings(through: ConditionRequirementDatabaseModel.self, from: \.$condition, to: \.$requirement)
    var requirements: [RequirementDatabaseModel]

    @Timestamp(key: FieldKeys.createdAt, on: .create) var createdAt: Date?
    @Timestamp(key: FieldKeys.updatedAt, on: .update) var updatedAt: Date?

    init() {}

    init(title: String) {
        self.title = title
    }
}
