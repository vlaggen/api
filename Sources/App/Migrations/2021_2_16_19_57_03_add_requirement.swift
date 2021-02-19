import Foundation
import Fluent

struct AddRequirementMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(RequirementDatabaseModel.schema)
                .id()
                .field(RequirementDatabaseModel.FieldKeys.when, .string, .required)
                .field(RequirementDatabaseModel.FieldKeys.operator, .string, .required)
                .field(RequirementDatabaseModel.FieldKeys.then, .string, .required)

                .field(RequirementDatabaseModel.FieldKeys.createdAt, .datetime, .required)
                .field(RequirementDatabaseModel.FieldKeys.updatedAt, .datetime, .required)

                .create(),
        ])
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(ParameterDatabaseModel.schema).delete(),
        ])
    }
}
