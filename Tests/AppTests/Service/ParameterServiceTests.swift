@testable import App
import Vapor
import XCTest
import XCTVapor

final class ParameterServiceTests: XCTestCase {

    private var app: Application!

    private var sut: ParameterService!

    // MARK: - Setup

    override func setUpWithError() throws {
        app = try createTestApp()

        sut = ParameterService()
    }

    override func tearDownWithError() throws {
        app.shutdown()
    }

    func test_list_shouldReturnAllCreatedAndSupportedStandardDataTypes() throws {
        // Given
        let _ = DatabaseHelper.createParameter(app: app, key: "key_1", standard: "key")
        let _ = DatabaseHelper.createParameter(app: app, key: "key_2", standard: 1)
        let _ = DatabaseHelper.createParameter(app: app, key: "key_3", standard: 1.4)
        let _ = DatabaseHelper.createParameter(app: app, key: "key_4", standard: true)

        let req = Request(application: app, on: app.nextEventLoop)

        // When
        try sut.list(db: req.db).whenCompleteAssertSuccess { (models) in
            // Then
            XCTAssertEqual(models.count, 4)
            XCTAssertEqual(models[0].key, "key_1")
            XCTAssertEqual(models[0].standard, "key".data)
            XCTAssertEqual(models[1].key, "key_2")
            XCTAssertEqual(models[1].standard, "1".data)
            XCTAssertEqual(models[2].key, "key_3")
            XCTAssertEqual(models[2].standard, "1.4".data)
            XCTAssertEqual(models[3].key, "key_4")
            XCTAssertEqual(models[3].standard, "true".data)
        }
    }
}

// MARK: - Helpers

fileprivate extension String {
    var data: Data {
        self.data(using: .utf8) ?? Data()
    }
}

