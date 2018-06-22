import Foundation
import Vapor
import Leaf

public struct GeneratedPage {
    var path: String
    var params: [PageParam]
}

public protocol PageProtocol {
    associatedtype Model: Codable
    
    var path: String { get }
    var payload: Model? { get }
    var params: [PageParam] { get }
    
    func generate(_ container: Container, fm: FileManager, tmpDir: String) throws -> EventLoopFuture<GeneratedPage>
}

public class Page<T>: PageProtocol where T: Codable {
    public var path: String
    public var payload: T?
    public var params: [PageParam] = []
    
    public init(view path: String,
            payload: T,
            params: PageParam...) {
        self.path = path
        self.payload = payload
        self.params = params
    }
    
    public init(url path: String, params: PageParam...) {
        self.path = path
        self.params = params
    }
    
    public func generate(_ container: Container, fm: FileManager, tmpDir: String) throws -> EventLoopFuture<GeneratedPage> {
        guard let payload = payload else {
            return container.eventLoop.newSucceededFuture(result: GeneratedPage(path: path, params: self.params))
        }
        let leaf = try container.make(LeafRenderer.self)
        return leaf.render(path, payload).map { view in
            let tmpFile = "\(tmpDir)/\(UUID().uuidString).html"
            fm.createFile(atPath: tmpFile, contents: view.data)
            return GeneratedPage(path: tmpFile, params: self.params)
        }
    }
}
