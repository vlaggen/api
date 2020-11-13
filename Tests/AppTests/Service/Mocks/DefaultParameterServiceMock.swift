@testable import App
import Vapor
import Fluent

final class DefaultParameterServiceMock: ParameterServiceLogic {

    var invokedList = false
    var invokedListCount = 0
    var invokedListParameters: (db: Database, Void)?
    var invokedListParametersList = [(db: Database, Void)]()
    var stubbedListError: Error?
    var stubbedListResult: EventLoopFuture<[ParameterDatabaseModel]>!

    func list(db: Database) throws -> EventLoopFuture<[ParameterDatabaseModel]> {
        invokedList = true
        invokedListCount += 1
        invokedListParameters = (db, ())
        invokedListParametersList.append((db, ()))
        if let error = stubbedListError {
            throw error
        }
        return stubbedListResult
    }
}
