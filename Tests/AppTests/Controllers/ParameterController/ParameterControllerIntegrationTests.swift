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

    // MARK: - Default parameters

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

    // MARK: - Parameters with conditions

    func test_get_api_v1_parameters_no_requirements_shouldReturnStandard() throws {
        // Given
        setupDatabaseWithMultipleConditions()

        // When
        try app.test(.GET, "/api/v1/parameters") { res in

            // Then
            XCTAssertContent([ParameterResponse].self, res) {
                XCTAssertEqual($0, [
                    ParameterResponse(key: "key_1", value: .string("this is standard")),
                ])
            }
        }
    }

    func test_get_api_v1_parameters_withSingleRequirement_shouldReturnValue() throws {
        // Given
        setupDatabaseWithMultipleConditions()

        // When
        try app.test(.GET, "/api/v1/parameters?language=nl") { res in

            // Then
            XCTAssertContent([ParameterResponse].self, res) {
                XCTAssertEqual($0, [
                    ParameterResponse(key: "key_1", value: .string("this is nl")),
                ])
            }
        }
    }

    func test_get_api_v1_parameters_withSingleRequirementButAlsoOtherRequirements_shouldReturnValue() throws {
        // Given
        setupDatabaseWithMultipleConditions()

        // When
        try app.test(.GET, "/api/v1/parameters?language=be") { res in

            // Then
            XCTAssertContent([ParameterResponse].self, res) {
                XCTAssertEqual($0, [
                    ParameterResponse(key: "key_1", value: .string("this is be")),
                ])
            }
        }
    }

    func test_get_api_v1_parameters_withSingleUnknownRequirement_shouldReturnStandard() throws {
        // Given
        setupDatabaseWithMultipleConditions()

        // When
        try app.test(.GET, "/api/v1/parameters?language=unknown") { res in

            // Then
            XCTAssertContent([ParameterResponse].self, res) {
                XCTAssertEqual($0, [
                    ParameterResponse(key: "key_1", value: .string("this is standard")),
                ])
            }
        }
    }

    func test_get_api_v1_parameters_withTwoRequirementsButSingleMatch_shouldReturnValue() throws {
        // Given
        setupDatabaseWithMultipleConditions()

        // When
        try app.test(.GET, "/api/v1/parameters?language=be&version=2") { res in

            // Then
            XCTAssertContent([ParameterResponse].self, res) {
                XCTAssertEqual($0, [
                    ParameterResponse(key: "key_1", value: .string("this is be")),
                ])
            }
        }
    }

    func test_get_api_v1_parameters_withTwoRequirementsEqual_shouldReturnValue() throws {
        // Given
        setupDatabaseWithMultipleConditions()

        // When
        try app.test(.GET, "/api/v1/parameters?language=be&version=3") { res in

            // Then
            XCTAssertContent([ParameterResponse].self, res) {
                XCTAssertEqual($0, [
                    ParameterResponse(key: "key_1", value: .string("this is be and version is 3")),
                ])
            }
        }
    }

    func test_get_api_v1_parameters_withTwoRequirementsLarger_shouldReturnValue() throws {
        // Given
        setupDatabaseWithMultipleConditions()

        // When
        try app.test(.GET, "/api/v1/parameters?language=be&version=100") { res in

            // Then
            XCTAssertContent([ParameterResponse].self, res) {
                XCTAssertEqual($0, [
                    ParameterResponse(key: "key_1", value: .string("this is be and version is larger than 3")),
                ])
            }
        }
    }

    // MARK: - Edge cases
    func test_get_api_v1_parameters_withStringLargerThan_shouldReturnStandard() throws {
        // Given
        setupDatabaseWithStringLargerThanConditions()

        // When
        try app.test(.GET, "/api/v1/parameters?language=be") { res in

            // Then
            XCTAssertContent([ParameterResponse].self, res) {
                XCTAssertEqual($0, [
                    ParameterResponse(key: "key_1", value: .string("this is standard")),
                ])
            }
        }

        try app.test(.GET, "/api/v1/parameters?language=nl") { res in

            // Then
            XCTAssertContent([ParameterResponse].self, res) {
                XCTAssertEqual($0, [
                    ParameterResponse(key: "key_1", value: .string("this is standard")),
                ])
            }
        }

        try app.test(.GET, "/api/v1/parameters?language=unknown") { res in

            // Then
            XCTAssertContent([ParameterResponse].self, res) {
                XCTAssertEqual($0, [
                    ParameterResponse(key: "key_1", value: .string("this is standard")),
                ])
            }
        }
    }

    func test_get_api_v1_parameters_withBoolRequirementTrue_shouldReturnValue() throws {
        setupDatabaseWithBoolRequirement()

        try app.test(.GET, "/api/v1/parameters?test=true") { res in

            // Then
            XCTAssertContent([ParameterResponse].self, res) {
                XCTAssertEqual($0, [
                    ParameterResponse(key: "key_1", value: .string("this is test value")),
                ])
            }
        }
    }

    func test_get_api_v1_parameters_withBoolRequirementFalse_shouldReturnStandard() throws {
        setupDatabaseWithBoolRequirement()

        try app.test(.GET, "/api/v1/parameters?test=false") { res in

            // Then
            XCTAssertContent([ParameterResponse].self, res) {
                XCTAssertEqual($0, [
                    ParameterResponse(key: "key_1", value: .string("this is standard")),
                ])
            }
        }
    }
}

private extension ParameterControllerIntegrationTests {
    func setupDatabaseWithMultipleConditions() {
        let parameter = DatabaseHelper.createParameter(app: app, key: "key_1", standard: "this is standard")

        let conditionNL = DatabaseHelper.createCondition(app: app, title: "Condition - NL")
        let conditionBe = DatabaseHelper.createCondition(app: app, title: "Condition - BE")
        let conditionBeAndV3 = DatabaseHelper.createCondition(app: app, title: "Condition - BE - V3")
        let conditionBeAndV3Plus = DatabaseHelper.createCondition(app: app, title: "Condition - BE - V3+")

        let _ = DatabaseHelper.createParameterConditionValue(app: app, parameterId: parameter.id!, conditionId: conditionNL.id!, value: "this is nl")
        let _ = DatabaseHelper.createParameterConditionValue(app: app, parameterId: parameter.id!, conditionId: conditionBe.id!, value: "this is be")
        let _ = DatabaseHelper.createParameterConditionValue(app: app, parameterId: parameter.id!, conditionId: conditionBeAndV3.id!, value: "this is be and version is 3")
        let _ = DatabaseHelper.createParameterConditionValue(app: app, parameterId: parameter.id!, conditionId: conditionBeAndV3Plus.id!, value: "this is be and version is larger than 3")

        let requirementLanguageNL = DatabaseHelper.createRequirement(app: app, when: "language", operator: "==", then: "nl")
        let requirementLanguageBe = DatabaseHelper.createRequirement(app: app, when: "language", operator: "==", then: "be")
        let requirementVersionLarger3 = DatabaseHelper.createRequirement(app: app, when: "version", operator: ">", then: "3")
        let requirementVersionEquals3 = DatabaseHelper.createRequirement(app: app, when: "version", operator: "==", then: "3")

        // NL
        let _ = DatabaseHelper.createConditionRequirement(app: app, conditionId: conditionNL.id!, requirementId: requirementLanguageNL.id!)

        // BE
        let _ = DatabaseHelper.createConditionRequirement(app: app, conditionId: conditionBe.id!, requirementId: requirementLanguageBe.id!)

        // BE & V == 3
        let _ = DatabaseHelper.createConditionRequirement(app: app, conditionId: conditionBeAndV3.id!, requirementId: requirementLanguageBe.id!)
        let _ = DatabaseHelper.createConditionRequirement(app: app, conditionId: conditionBeAndV3.id!, requirementId: requirementVersionEquals3.id!)

        // BE & V > 3
        let _ = DatabaseHelper.createConditionRequirement(app: app, conditionId: conditionBeAndV3Plus.id!, requirementId: requirementLanguageBe.id!)
        let _ = DatabaseHelper.createConditionRequirement(app: app, conditionId: conditionBeAndV3Plus.id!, requirementId: requirementVersionLarger3.id!)
    }

    func setupDatabaseWithStringLargerThanConditions() {
        let parameter = DatabaseHelper.createParameter(app: app, key: "key_1", standard: "this is standard")

        let conditionNL = DatabaseHelper.createCondition(app: app, title: "Condition - NL")
        let conditionBe = DatabaseHelper.createCondition(app: app, title: "Condition - BE")

        let _ = DatabaseHelper.createParameterConditionValue(app: app, parameterId: parameter.id!, conditionId: conditionNL.id!, value: "this is nl")
        let _ = DatabaseHelper.createParameterConditionValue(app: app, parameterId: parameter.id!, conditionId: conditionBe.id!, value: "this is be")

        let requirementLanguageNL = DatabaseHelper.createRequirement(app: app, when: "language", operator: ">", then: "nl")
        let requirementLanguageBe = DatabaseHelper.createRequirement(app: app, when: "language", operator: "<", then: "be")

        // NL
        let _ = DatabaseHelper.createConditionRequirement(app: app, conditionId: conditionNL.id!, requirementId: requirementLanguageNL.id!)

        // BE
        let _ = DatabaseHelper.createConditionRequirement(app: app, conditionId: conditionBe.id!, requirementId: requirementLanguageBe.id!)
    }

    func setupDatabaseWithBoolRequirement() {
        let parameter = DatabaseHelper.createParameter(app: app, key: "key_1", standard: "this is standard")

        let condition = DatabaseHelper.createCondition(app: app, title: "Condition - Bool")

        let _ = DatabaseHelper.createParameterConditionValue(app: app, parameterId: parameter.id!, conditionId: condition.id!, value: "this is test value")

        let requirementTest = DatabaseHelper.createRequirement(app: app, when: "test", operator: "==", then: "true")

        let _ = DatabaseHelper.createConditionRequirement(app: app, conditionId: condition.id!, requirementId: requirementTest.id!)
    }
}
