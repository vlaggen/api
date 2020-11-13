@testable import App
import Vapor
import XCTest

final class ParameterControllerTests: XCTestCase {

    private var app: Application!

    private var sut: ParameterController!

    private var mockService: DefaultParameterServiceMock!


    // MARK: - Setup

    override func setUpWithError() throws {
        app = try createTestApp()

        mockService = DefaultParameterServiceMock()
        sut = ParameterController(service: mockService)
    }

    override func tearDownWithError() throws {
        app.shutdown()
    }

    func test_all_withSuccess_shouldReturnParameters() throws {
        // Given
        let databaseModel = DatabaseHelper.createParameter(app: app, key: "key", standard: "This is nice.")
        mockService.stubbedListResult = app.nextEventLoop.makeSucceededFuture([databaseModel])

        let req = Request(application: app, on: app.nextEventLoop)

        // When
        try sut.all(req: req).whenCompleteAssertSuccess { (parameters) in
            // Then
            let expectedParameter = ParameterResponse(key: "key", value: .string("This is nice."))
            XCTAssertEqual(parameters.first, expectedParameter)
            XCTAssertEqual(parameters.count, 1)
        }

        // Then
        XCTAssertTrue(mockService.invokedList)
    }

    func test_all_withFailure_shouldThrowError() throws {
        // Given
        mockService.stubbedListError = TestError()

        let req = Request(application: app, on: app.nextEventLoop)

        // When
        XCTAssertThrowsError(try sut.all(req: req)) { (error) in
            XCTAssertTrue(error is TestError)
        }

        // Then
        XCTAssertTrue(mockService.invokedList)
    }
}
