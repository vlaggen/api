import Vapor
import XCTVapor

extension XCTApplicationTester {

    @discardableResult func test<T>(
        _ method: HTTPMethod,
        _ path: String,
        headers: HTTPHeaders = [:],
        content: T,
        afterResponse: (XCTHTTPResponse) throws -> () = { _ in }
    ) throws -> XCTApplicationTester where T: Codable {
        try test(method, path, headers: headers, beforeRequest: { req in
            try req.content.encode(content, as: .json)
        }, afterResponse: afterResponse)
    }
}
