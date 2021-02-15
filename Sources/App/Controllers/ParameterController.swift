import Vapor
import Fluent
import VlaggenNetworkModels

struct ParameterController {

    private let service: ParameterServiceLogic

    init(service: ParameterServiceLogic = ParameterService()) {
        self.service = service
    }

    func all(req: Request) throws -> EventLoopFuture<[ParameterResponse]> {
        return try service.list(db: req.db)
            .mapEachCompact { $0.mapToParameterResponse }
    }

    func routes(routes: RoutesBuilder) {
        // All
        routes.get(use: self.all)
    }
}
