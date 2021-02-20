import Foundation
import Fluent

struct AddParameterConditionValueMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(ParameterConditionValueDatabaseModel.schema)
                .id()
                .field(ParameterConditionValueDatabaseModel.FieldKeys.value, .data, .required)

                .field(ParameterConditionValueDatabaseModel.FieldKeys.parameterId, .uuid, .required)
                .field(ParameterConditionValueDatabaseModel.FieldKeys.conditionId, .uuid, .required)

                .field(ParameterDatabaseModel.FieldKeys.createdAt, .datetime, .required)
                .field(ParameterDatabaseModel.FieldKeys.updatedAt, .datetime, .required)

                .create(),
        ])
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(ParameterConditionValueDatabaseModel.schema).delete(),
        ])
    }
}
