import Foundation
import Fluent

struct AddUserMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(UserDatabaseModel.schema)
                .id()
                .field(UserDatabaseModel.FieldKeys.email, .string, .required)
                .field(UserDatabaseModel.FieldKeys.password, .string, .required)

                .field(UserDatabaseModel.FieldKeys.firstName, .string)

                .field(UserDatabaseModel.FieldKeys.createdAt, .datetime, .required)
                .field(UserDatabaseModel.FieldKeys.updatedAt, .datetime, .required)

                .unique(on: UserDatabaseModel.FieldKeys.email, name: "uq:email")

                .create(),
        ])
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(UserDatabaseModel.schema).delete(),
        ])
    }
}
