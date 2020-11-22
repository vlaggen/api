@testable import App
import Vapor
import XCTest
import XCTVapor
import VlaggenNetworkModels

final class ParameterControllerIntegrationTests: XCTestCase {

    private var app: Application!

    private var sut: ParameterController!

    // MARK: - Setup

    override func setUpWithError() throws {
        app = try createTestApp()

        sut = ParameterController()
    }

    override func tearDownWithError() throws {
        app.shutdown()
    }

    func test_get_api_v1_parameters_shouldReturnParameters() throws {
        // Given
        let _ = DatabaseHelper.createParameter(app: app, key: "key_1", standard: "value")
        let _ = DatabaseHelper.createParameter(app: app, key: "key_2", standard: 1)
        let _ = DatabaseHelper.createParameter(app: app, key: "key_3", standard: 1.4)
        let _ = DatabaseHelper.createParameter(app: app, key: "key_4", standard: true)

        // When
        try app.test(.GET, "/api/v1/parameters") { res in

            // Then
            XCTAssertContent([ParameterResponse].self, res) {
                XCTAssertEqual($0, [
                    ParameterResponse(key: "key_1", value: .string("value")),
                    ParameterResponse(key: "key_2", value: .double(1)),
                    ParameterResponse(key: "key_3", value: .double(1.4)),
                    ParameterResponse(key: "key_4", value: .bool(true)),
                ])
            }
        }
    }
}
