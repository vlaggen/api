import Foundation
import Fluent

struct AddParameterMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(ParameterDatabaseModel.schema)
                .id()
                .field(ParameterDatabaseModel.FieldKeys.key, .string, .required)
                .field(ParameterDatabaseModel.FieldKeys.description, .string, .required)
                .field(ParameterDatabaseModel.FieldKeys.standard, .data, .required)

                .field(ParameterDatabaseModel.FieldKeys.createdAt, .datetime, .required)
                .field(ParameterDatabaseModel.FieldKeys.updatedAt, .datetime, .required)

                .unique(on: ParameterDatabaseModel.FieldKeys.key, name: "uq:key")

                .create(),
        ])
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(ParameterDatabaseModel.schema).delete(),
        ])
    }
}
