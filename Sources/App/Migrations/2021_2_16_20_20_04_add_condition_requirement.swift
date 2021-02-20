import Foundation
import Fluent

struct AddConditionRequirementMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(ConditionRequirementDatabaseModel.schema)
                .id()
                .field(ConditionRequirementDatabaseModel.FieldKeys.conditionId, .uuid, .required)
                .field(ConditionRequirementDatabaseModel.FieldKeys.requirementId, .uuid, .required)

                .field(ConditionRequirementDatabaseModel.FieldKeys.createdAt, .datetime, .required)
                .field(ConditionRequirementDatabaseModel.FieldKeys.updatedAt, .datetime, .required)

                .create(),
        ])
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(ConditionRequirementDatabaseModel.schema).delete(),
        ])
    }
}
