import Foundation
import Fluent

struct AddConditionMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(ConditionDatabaseModel.schema)
                .id()
                .field(ConditionDatabaseModel.FieldKeys.title, .string, .required)

                .field(ConditionDatabaseModel.FieldKeys.createdAt, .datetime, .required)
                .field(ConditionDatabaseModel.FieldKeys.updatedAt, .datetime, .required)

                .create(),
        ])
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(ConditionDatabaseModel.schema).delete(),
        ])
    }
}
