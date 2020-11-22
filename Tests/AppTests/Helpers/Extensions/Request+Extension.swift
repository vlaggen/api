import Foundation
import Vapor

extension Request {

    convenience init(
        application: Application,
        body: Encodable,
        on eventLoop: EventLoop
    ) throws {
        let data = try body.data()
        let byteBuffer = ByteBuffer(data: data)

        let headers = HTTPHeaders(dictionaryLiteral: ("Content-Type", "application/json"))
        self.init(application: application, headers: headers, collectedBody: byteBuffer, on: eventLoop)
    }
}

private extension Encodable {
    func data() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
}
