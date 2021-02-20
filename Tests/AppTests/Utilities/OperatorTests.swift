@testable import App
import Vapor
import XCTest

final class OperatorTests: XCTestCase {

    func test_equal() {
        // Given
        let `operator` = "=="

        // When
        let sut = Operator(rawValue: `operator`)

        // Then
        XCTAssertEqual(sut, .equal)
    }

    func test_notEqual() {
        // Given
        let `operator` = "!="

        // When
        let sut = Operator(rawValue: `operator`)

        // Then
        XCTAssertEqual(sut, .notEqual)
    }

    func test_greater() {
        // Given
        let `operator` = ">"

        // When
        let sut = Operator(rawValue: `operator`)

        // Then
        XCTAssertEqual(sut, .greater)
    }

    func test_less() {
        // Given
        let `operator` = "<"

        // When
        let sut = Operator(rawValue: `operator`)

        // Then
        XCTAssertEqual(sut, .less)
    }

    func test_largerAndEqual() {
        // Given
        let `operator` = ">="

        // When
        let sut = Operator(rawValue: `operator`)

        // Then
        XCTAssertNil(sut)
    }

    func test_lessAndEqual() {
        // Given
        let `operator` = "<="

        // When
        let sut = Operator(rawValue: `operator`)

        // Then
        XCTAssertNil(sut)
    }

    func test_sentence() {
        // Given
        let `operator` = "wow, this should never be an operator"

        // When
        let sut = Operator(rawValue: `operator`)

        // Then
        XCTAssertNil(sut)
    }

    func test_garbage() {
        // Given
        let `operator` = "🗑"

        // When
        let sut = Operator(rawValue: `operator`)

        // Then
        XCTAssertNil(sut)
    }
}

