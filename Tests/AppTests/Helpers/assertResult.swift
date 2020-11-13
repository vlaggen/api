import Foundation
import Vapor
import XCTest

func assertResultSuccess<T>(_ result: Result<T, Error>, assertions: (T) -> ()) {
    switch result {
        case .success(let success):
            assertions(success)
        case .failure(let error):
            XCTFail("Test should have success result but received: \(error)")
    }
}

extension EventLoopFuture {
    func whenCompleteAssertSuccess(assertions: @escaping (Value) -> ()) {
        whenComplete { (result) in
            assertResultSuccess(result, assertions: assertions)
        }
    }
}
