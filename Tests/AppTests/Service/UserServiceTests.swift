@testable import App
import Vapor
import XCTest
import XCTVapor
import VlaggenNetworkModels

final class UserServiceTests: XCTestCase {

    private var app: Application!

    private var sut: UserService!

    // MARK: - Setup

    override func setUpWithError() throws {
        app = try createTestApp()

        sut = UserService()
    }

    override func tearDownWithError() throws {
        app.shutdown()
    }

    func test_create_shouldReturnCreated() throws {
        // Given
        let input = UserCreateRequest(email: "test@example.org", password: "123", firstName: nil)
        let req = Request(application: app, on: app.nextEventLoop)

        // When
        try sut.create(db: req.db, password: req.password, input: input).whenCompleteAssertSuccess { (status) in
            // Then
            XCTAssertEqual(status, .created)
        }
    }

    func test_create_shouldHashPassword() throws {
        // Given
        let input = UserCreateRequest(email: "test@example.org", password: "123", firstName: nil)
        let req = Request(application: app, on: app.nextEventLoop)

        // When
        try sut.create(db: req.db, password: req.password, input: input)
            .transform(to: UserDatabaseModel.query(on: req.db).first())
            .whenCompleteAssertSuccess { (user) in
                XCTAssertEqual(user?.email, "test@example.org")
                XCTAssertEqual(user?.password.count, 60)
                XCTAssertNotEqual(user?.password, "123")
            }
    }


    func test_create_withDuplicateEmail_shouldReturnConflicted() throws {
        // Given
        DatabaseHelper.createUser(app: app, email: "test@example.org")
        let req = Request(application: app, on: app.nextEventLoop)

        let input = UserCreateRequest(email: "test@example.org", password: "123", firstName: nil)

        // When
        try sut.create(db: req.db, password: req.password, input: input).whenFailure { (error) in
            // Then
            XCTAssertEqual(error.localizedDescription, Abort(.conflict).errorDescription)
        }
    }

}
