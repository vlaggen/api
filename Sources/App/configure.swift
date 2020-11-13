import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    try app.databases.use(.postgres(url: Environment.databaseURL), as: .psql)

    // Register routes
    try routes(app)

    app.migrations.add([
        AddParameterMigration(),
    ])
}
