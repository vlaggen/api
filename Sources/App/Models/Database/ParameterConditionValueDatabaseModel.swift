import Vapor
import Fluent

final class ParameterConditionValueDatabaseModel: Model {
    static let schema = "parameter+condition_has_value"

    struct FieldKeys {
        static var value: FieldKey { "value" }

        static var parameterId: FieldKey { "parameterId" }
        static var conditionId: FieldKey { "conditionId" }

        static var createdAt: FieldKey { "created_at" }
        static var updatedAt: FieldKey { "updated_at" }
    }

    @ID() var id: UUID?
    @Field(key: FieldKeys.value) var value: Data

    @Parent(key: FieldKeys.parameterId) var parameter: ParameterDatabaseModel
    @Field(key: FieldKeys.parameterId) var parameterId: ParameterDatabaseModel.IDValue

    @Parent(key: FieldKeys.conditionId) var condition: ConditionDatabaseModel
    @Field(key: FieldKeys.conditionId) var conditionId: ConditionDatabaseModel.IDValue

    @Timestamp(key: FieldKeys.createdAt, on: .create) var createdAt: Date?
    @Timestamp(key: FieldKeys.updatedAt, on: .update) var updatedAt: Date?
}
