import Foundation
import Fluent

struct AddConditionRequirementMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(ConditionRequirementDatabaseModel.schema)
                .id()
                .field(ConditionRequirementDatabaseModel.FieldKeys.conditionId, .uuid, .required)
                .field(ConditionRequirementDatabaseModel.FieldKeys.requirementId, .uuid, .required)

                .field(RequirementDatabaseModel.FieldKeys.createdAt, .datetime, .required)
                .field(RequirementDatabaseModel.FieldKeys.updatedAt, .datetime, .required)

//                .unique(on: ParameterDatabaseModel.FieldKeys.key, name: "uq:key") // TODO

                .create(),
        ])
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(ConditionRequirementDatabaseModel.schema).delete(),
        ])
    }
}
