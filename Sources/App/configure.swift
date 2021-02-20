import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {

    if var postgresConfig = PostgresConfiguration(url: Environment.databaseURL), Environment.unverifiedTLS {
        postgresConfig.tlsConfiguration = .forClient(certificateVerification: .none)
        app.databases.use(.postgres(configuration: postgresConfig), as: .psql)
    } else {
        try app.databases.use(.postgres(url: Environment.databaseURL), as: .psql)
    }

    // Register routes
    try routes(app)

    app.migrations.add([
        AddParameterMigration(),
        AddConditionMigration(),
        AddRequirementMigration(),
        AddConditionRequirementMigration(),
        AddParameterConditionValueMigration(),
    ])
}
