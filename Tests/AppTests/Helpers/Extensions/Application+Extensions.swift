import Vapor

extension Application {
    var nextEventLoop: EventLoop {
        eventLoopGroup.next()
    }
}
