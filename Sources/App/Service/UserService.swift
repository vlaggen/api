import Vapor
import Fluent
import VlaggenNetworkModels

protocol UserServiceLogic {
    func create(db: Database, password: Request.Password, input: UserCreateRequest) throws -> EventLoopFuture<HTTPStatus>
}

struct UserService: UserServiceLogic {

    func create(db: Database, password: Request.Password, input: UserCreateRequest) throws -> EventLoopFuture<HTTPStatus> {
        let hash = try password.sync.hash(input.password)
        let user = UserDatabaseModel(email: input.email, password: hash, firstName: input.firstName)
        return user.save(on: db)
            .flatMapErrorThrowing {
                if let error = $0 as? DatabaseError, error.isConstraintFailure {
                    throw Abort(.conflict)
                }
                throw $0
            }.transform(to: .created)
    }
}
