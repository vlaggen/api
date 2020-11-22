@testable import App
import Vapor
import XCTest
import XCTVapor
import VlaggenNetworkModels

final class UserCreateRequestValidatableTests: XCTestCase {
    private var app: Application!

    // MARK: - Setup

    override func setUpWithError() throws {
        app = try createTestApp()
    }

    override func tearDownWithError() throws {
        app.shutdown()
    }

    func test_validate_withEmptyEmail_shouldThrowError() throws {
        // Given
        let user = UserCreateRequest(email: "", password: "123456789", firstName: nil)

        let req = try Request(application: app, body: user, on: app.nextEventLoop)

        // When
        XCTAssertThrowsError(try UserCreateRequest.validate(content: req)) {
            guard let error = $0 as? ValidationsError else { return XCTFail() }

            // Then
            XCTAssertEqual(error.failures.count, 1)
            XCTAssertEqual(error.failures.first?.key.stringValue, "email")
            XCTAssertEqual(error.failures.first?.result.failureDescription, "is not a valid email address")
        }
    }

    func test_validate_withInvalidEmail_shouldThrowError() throws {
        // Given
        let user = UserCreateRequest(email: "test[at]example.com", password: "123456789", firstName: nil)

        let req = try Request(application: app, body: user, on: app.nextEventLoop)

        // When
        XCTAssertThrowsError(try UserCreateRequest.validate(content: req)) {
            guard let error = $0 as? ValidationsError else { return XCTFail() }

            // Then
            XCTAssertEqual(error.failures.count, 1)
            XCTAssertEqual(error.failures.first?.key.stringValue, "email")
            XCTAssertEqual(error.failures.first?.result.failureDescription, "is not a valid email address")
        }
    }

    func test_validate_withEmptyPassword_shouldThrowError() throws {
        // Given
        let user = UserCreateRequest(email: "test@example.com", password: "", firstName: nil)

        let req = try Request(application: app, body: user, on: app.nextEventLoop)

        // When
        XCTAssertThrowsError(try UserCreateRequest.validate(content: req)) {
            guard let error = $0 as? ValidationsError else { return XCTFail() }

            // Then
            XCTAssertEqual(error.failures.count, 1)
            XCTAssertEqual(error.failures.first?.key.stringValue, "password")
            XCTAssertEqual(error.failures.first?.result.failureDescription, "is less than minimum of 9 character(s)")
        }
    }

    func test_validate_withValidEmailAndPassword_shouldNotThrowError() throws {
        // Given
        let user = UserCreateRequest(email: "test@example.com", password: "123456789", firstName: nil)

        let req = try Request(application: app, body: user, on: app.nextEventLoop)

        // When
        try UserCreateRequest.validate(content: req)
    }

}
