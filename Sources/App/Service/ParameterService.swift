import Vapor
import Fluent

protocol ParameterServiceLogic {
    func list(db: Database) throws -> EventLoopFuture<[ParameterDatabaseModel]>
}

struct ParameterService: ParameterServiceLogic {

    func list(db: Database) throws -> EventLoopFuture<[ParameterDatabaseModel]> {
        return ParameterDatabaseModel
            .query(on: db)
            .with(\.$conditions)
            .with(\.$conditions, { loader in
                loader.with(\.$requirements)
            })
            .with(\.$conditionValues)
            .all()
    }
}
