import Vapor
import Fluent
import VlaggenNetworkModels

struct UserController {

    private let service: UserServiceLogic

    init(service: UserServiceLogic = UserService()) {
        self.service = service
    }

    func register(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        try UserCreateRequest.validate(content: req)
        let input = try req.content.decode(UserCreateRequest.self)

        return try service.create(db: req.db, password: req.password, input: input)
    }

    func routes(routes: RoutesBuilder) {
        // Create
        routes.post("create", use: self.register)
    }
}
