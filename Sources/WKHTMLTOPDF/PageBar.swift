import Foundation
import Vapor
import Leaf

public struct GeneratedPageBar {
    var path: String
}

public protocol PageBarProtocol {
    func generate(_ container: Container, fm: FileManager, tmpDir: String) throws -> EventLoopFuture<GeneratedPageBar>
}

public class PageBar<T>: PageBarProtocol where T: Codable {
    public var path: String
    public var payload: T?
    
    public init(view path: String, payload: T) {
        self.path = path
        self.payload = payload
    }
    
    public func generate(_ container: Container, fm: FileManager, tmpDir: String) throws -> EventLoopFuture<GeneratedPageBar> {
        guard let payload = payload else {
            return container.eventLoop.newSucceededFuture(result: GeneratedPageBar(path: path))
        }
        let leaf = try container.make(LeafRenderer.self)
        return leaf.render(path, payload).map { view in
            let tmpFile = "\(tmpDir)/\(UUID().uuidString).html"
            _ = fm.createFile(atPath: tmpFile, contents: view.data)
            return GeneratedPageBar(path: tmpFile)
        }
    }
}
