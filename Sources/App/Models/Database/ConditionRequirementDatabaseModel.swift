import Vapor
import Fluent

final class ConditionRequirementDatabaseModel: Model {
    static let schema = "condition+requirement"

    struct FieldKeys {
        static var conditionId: FieldKey { "conditionId" }
        static var requirementId: FieldKey { "requirementId" }

        static var createdAt: FieldKey { "created_at" }
        static var updatedAt: FieldKey { "updated_at" }
    }

    @ID() var id: UUID?

    @Parent(key: FieldKeys.conditionId) var condition: ConditionDatabaseModel
    @Field(key: FieldKeys.conditionId) var conditionId: ConditionDatabaseModel.IDValue

    @Parent(key: FieldKeys.requirementId) var requirement: RequirementDatabaseModel
    @Field(key: FieldKeys.requirementId) var requirementId: RequirementDatabaseModel.IDValue

    @Timestamp(key: FieldKeys.createdAt, on: .create) var createdAt: Date?
    @Timestamp(key: FieldKeys.updatedAt, on: .update) var updatedAt: Date?

    init() {}

    init(conditionId: ConditionDatabaseModel.IDValue,
         requirementId: RequirementDatabaseModel.IDValue
    ) {
        self.conditionId = conditionId
        self.requirementId = requirementId
    }
}
