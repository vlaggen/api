@testable import App
import Vapor
import XCTest

final class ComparatorTests: XCTestCase {

    // MARK: - Double

    func test_double_equal_whenEqual_shouldReturnTrue() {
        // Given
        let lhs: Double = 1.23
        let rhs: Double = 1.230

        // When
        let result = Comparator.compare(lhs: lhs, operator: .equal, rhs: rhs)

        // Then
        XCTAssertTrue(result)
    }

    func test_double_equal_whenNotEqual_shouldReturnFalse() {
        // Given
        let lhs: Double = 1.23
        let rhs: Double = 2.34

        // When
        let result = Comparator.compare(lhs: lhs, operator: .equal, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_double_notEqual_whenNotEqual_shouldReturnTrue() {
        // Given
        let lhs: Double = 1.23567
        let rhs: Double = 1.23456

        // When
        let result = Comparator.compare(lhs: lhs, operator: .notEqual, rhs: rhs)

        // Then
        XCTAssertTrue(result)
    }

    func test_double_notEqual_whenEqual_shouldReturnFalse() {
        // Given
        let lhs: Double = 1.23
        let rhs: Double = 1.23

        // When
        let result = Comparator.compare(lhs: lhs, operator: .notEqual, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_double_greater_whenGreater_shouldReturnTrue() {
        // Given
        let lhs: Double = 2.34
        let rhs: Double = 1.23

        // When
        let result = Comparator.compare(lhs: lhs, operator: .greater, rhs: rhs)

        // Then
        XCTAssertTrue(result)
    }

    func test_double_greater_whenLess_shouldReturnFalse() {
        // Given
        let lhs: Double = 1.23
        let rhs: Double = 2.34

        // When
        let result = Comparator.compare(lhs: lhs, operator: .greater, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_double_greater_whenEqual_shouldReturnFalse() {
        // Given
        let lhs: Double = 1.23
        let rhs: Double = 1.230

        // When
        let result = Comparator.compare(lhs: lhs, operator: .greater, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_double_less_whenLess_shouldReturnTrue() {
        // Given
        let lhs: Double = 1.23
        let rhs: Double = 2.34

        // When
        let result = Comparator.compare(lhs: lhs, operator: .less, rhs: rhs)

        // Then
        XCTAssertTrue(result)
    }

    func test_double_less_whenGreater_shouldReturnFalse() {
        // Given
        let lhs: Double = 2.34
        let rhs: Double = 1.23

        // When
        let result = Comparator.compare(lhs: lhs, operator: .less, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_double_less_whenEqual_shouldReturnFalse() {
        // Given
        let lhs: Double = 1.23
        let rhs: Double = 1.230

        // When
        let result = Comparator.compare(lhs: lhs, operator: .less, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    // MARK: - String

    func test_string_equal_whenEqual_shouldReturnTrue() {
        // Given
        let lhs: String = "value"
        let rhs: String = "value"

        // When
        let result = Comparator.compare(lhs: lhs, operator: .equal, rhs: rhs)

        // Then
        XCTAssertTrue(result)
    }

    func test_string_equal_whenNotEqual_shouldReturnFalse() {
        // Given
        let lhs: String = "value"
        let rhs: String = "other-value"

        // When
        let result = Comparator.compare(lhs: lhs, operator: .equal, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_string_notEqual_whenNotEqual_shouldReturnTrue() {
        // Given
        let lhs: String = "value"
        let rhs: String = "other-value"

        // When
        let result = Comparator.compare(lhs: lhs, operator: .notEqual, rhs: rhs)

        // Then
        XCTAssertTrue(result)
    }

    func test_string_notEqual_whenEqual_shouldReturnFalse() {
        // Given
        let lhs: String = "value"
        let rhs: String = "value"

        // When
        let result = Comparator.compare(lhs: lhs, operator: .notEqual, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_string_greater_whenGreater_shouldReturnFalse() {
        // Given
        let lhs: String = "this is a large string!"
        let rhs: String = "small string"

        // When
        let result = Comparator.compare(lhs: lhs, operator: .greater, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_string_greater_whenLess_shouldReturnFalse() {
        // Given
        let lhs: String = "small string"
        let rhs: String = "this is a large string!"

        // When
        let result = Comparator.compare(lhs: lhs, operator: .greater, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_string_greater_whenEqual_shouldReturnFalse() {
        // Given
        let lhs: String = "this is a large string!"
        let rhs: String = "this is a large string!"

        // When
        let result = Comparator.compare(lhs: lhs, operator: .greater, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_string_less_whenLess_shouldReturnFalse() {
        // Given
        let lhs: String = "small string"
        let rhs: String = "this is a large string!"

        // When
        let result = Comparator.compare(lhs: lhs, operator: .less, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_string_less_whenGreater_shouldReturnFalse() {
        // Given
        let lhs: String = "this is a large string!"
        let rhs: String = "small string"

        // When
        let result = Comparator.compare(lhs: lhs, operator: .less, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_string_less_whenEqual_shouldReturnFalse() {
        // Given
        let lhs: String = "this is a large string!"
        let rhs: String = "this is a large string!"

        // When
        let result = Comparator.compare(lhs: lhs, operator: .less, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    // MARK: - Bool

    func test_bool_equal_whenEqual_shouldReturnTrue() {
        // Given
        let lhs: Bool = true
        let rhs: Bool = true

        // When
        let result = Comparator.compare(lhs: lhs, operator: .equal, rhs: rhs)

        // Then
        XCTAssertTrue(result)
    }

    func test_bool_equal_whenNotEqual_shouldReturnFalse() {
        // Given
        let lhs: Bool = true
        let rhs: Bool = false

        // When
        let result = Comparator.compare(lhs: lhs, operator: .equal, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_bool_notEqual_whenNotEqual_shouldReturnTrue() {
        // Given
        let lhs: Bool = true
        let rhs: Bool = false

        // When
        let result = Comparator.compare(lhs: lhs, operator: .notEqual, rhs: rhs)

        // Then
        XCTAssertTrue(result)
    }

    func test_bool_notEqual_whenEqual_shouldReturnFalse() {
        // Given
        let lhs: Bool = false
        let rhs: Bool = false

        // When
        let result = Comparator.compare(lhs: lhs, operator: .notEqual, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_bool_greater_whenGreater_shouldReturnFalse() {
        // Given
        let lhs: Bool = true
        let rhs: Bool = false

        // When
        let result = Comparator.compare(lhs: lhs, operator: .greater, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_bool_greater_whenLess_shouldReturnFalse() {
        // Given
        let lhs: Bool = false
        let rhs: Bool = true

        // When
        let result = Comparator.compare(lhs: lhs, operator: .greater, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_bool_greater_whenEqual_shouldReturnFalse() {
        // Given
        let lhs: Bool = true
        let rhs: Bool = true

        // When
        let result = Comparator.compare(lhs: lhs, operator: .greater, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_bool_less_whenLess_shouldReturnFalse() {
        // Given
        let lhs: Bool = false
        let rhs: Bool = true

        // When
        let result = Comparator.compare(lhs: lhs, operator: .less, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_bool_less_whenGreater_shouldReturnFalse() {
        // Given
        let lhs: Bool = false
        let rhs: Bool = true

        // When
        let result = Comparator.compare(lhs: lhs, operator: .less, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_bool_less_whenEqual_shouldReturnFalse() {
        // Given
        let lhs: Bool = true
        let rhs: Bool = true

        // When
        let result = Comparator.compare(lhs: lhs, operator: .less, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    // MARK: - Int

    func test_int_equal_whenEqual_shouldReturnTrue() {
        // Given
        let lhs: Int = 3
        let rhs: Int = 3

        // When
        let result = Comparator.compare(lhs: lhs, operator: .equal, rhs: rhs)

        // Then
        XCTAssertTrue(result)
    }

    func test_int_equal_whenNotEqual_shouldReturnFalse() {
        // Given
        let lhs: Int = 3
        let rhs: Int = 5

        // When
        let result = Comparator.compare(lhs: lhs, operator: .equal, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_int_notEqual_whenNotEqual_shouldReturnTrue() {
        // Given
        let lhs: Int = 3
        let rhs: Int = 5

        // When
        let result = Comparator.compare(lhs: lhs, operator: .notEqual, rhs: rhs)

        // Then
        XCTAssertTrue(result)
    }

    func test_int_notEqual_whenEqual_shouldReturnFalse() {
        // Given
        let lhs: Int = 3
        let rhs: Int = 3

        // When
        let result = Comparator.compare(lhs: lhs, operator: .notEqual, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_int_greater_whenGreater_shouldReturnTrue() {
        // Given
        let lhs: Int = 5
        let rhs: Int = 3

        // When
        let result = Comparator.compare(lhs: lhs, operator: .greater, rhs: rhs)

        // Then
        XCTAssertTrue(result)
    }

    func test_int_greater_whenLess_shouldReturnFalse() {
        // Given
        let lhs: Int = 3
        let rhs: Int = 5

        // When
        let result = Comparator.compare(lhs: lhs, operator: .greater, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_int_greater_whenEqual_shouldReturnFalse() {
        // Given
        let lhs: Int = 3
        let rhs: Int = 3

        // When
        let result = Comparator.compare(lhs: lhs, operator: .greater, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_int_less_whenLess_shouldReturnTrue() {
        // Given
        let lhs: Int = 3
        let rhs: Int = 5

        // When
        let result = Comparator.compare(lhs: lhs, operator: .less, rhs: rhs)

        // Then
        XCTAssertTrue(result)
    }

    func test_int_less_whenGreater_shouldReturnFalse() {
        // Given
        let lhs: Int = 5
        let rhs: Int = 3

        // When
        let result = Comparator.compare(lhs: lhs, operator: .less, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }

    func test_int_less_whenEqual_shouldReturnFalse() {
        // Given
        let lhs: Int = 3
        let rhs: Int = 3

        // When
        let result = Comparator.compare(lhs: lhs, operator: .less, rhs: rhs)

        // Then
        XCTAssertFalse(result)
    }
}

