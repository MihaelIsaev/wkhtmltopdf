import Foundation
import Vapor

extension Array where Element: PageProtocol {
    func forEach(on container: Container, fm: FileManager, tmpDir: String, iteration: @escaping (GeneratedPage) -> (Void)) throws -> Future<Void> {
        let next: ()->(Future<Void>) = {
            return container.eventLoop.submit { () -> Void in
                return
            }
        }
        var items = self
        var iterateElement: (() throws -> (Future<Void>))!
        iterateElement = {
            if let item = items.first {
                return try item.generate(container, fm: fm, tmpDir: tmpDir).flatMap { generatedPage -> EventLoopFuture<Void> in
                    iteration(generatedPage)
                    items.removeFirst()
                    if items.count > 0 {
                        return try iterateElement()
                    }
                    return next()
                }
            } else {
                return next()
            }
        }
        return try iterateElement()
    }
}
