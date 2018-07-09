import Foundation
import Core
import Vapor
import Leaf

public typealias WK = WKHTMLTOPDF

public class WKHTMLTOPDF {
    private var params: [GeneralParam] = []
    private var pathToBinary = "/usr/local/bin/wkhtmltopdf"
    private var tmpDir = "/tmp/wkhtmltopdf"
    
    public init (pathToBinary: String? = nil, tmpDir: String? = nil, _ params: GeneralParam...) {
        self.params = params
        if let pathToBinary = pathToBinary {
            self.pathToBinary = pathToBinary
        }
        if let tmpDir = tmpDir {
            self.tmpDir = tmpDir
        }
    }
    
    public func generate<Page>(container: Container, pages: Page...) throws -> EventLoopFuture<Data> where Page: PageProtocol {
        let fm = FileManager()
        try fm.createDirectory(atPath: tmpDir, withIntermediateDirectories: true)
        
        var generatedPages: [GeneratedPage] = []
        return try pages.forEach(on: container, fm: fm, tmpDir: self.tmpDir) { page in
            generatedPages.append(page)
            }.flatMap {
                defer {
                    for page in generatedPages {
                        try? fm.removeItem(atPath: page.path)
                    }
                }
                let pageArgs = generatedPages.flatMap { page -> [String] in
                    var result = page.params.flatMap { $0.values }
                    result.append(page.path)
                    return result
                }
                let wk = Process()
                let stdout = Pipe()
                wk.launchPath = self.pathToBinary
                if !self.params.contains(.quiet) {
                    self.params.append(.quiet)
                }
                let bars = [try self.leafHeader(on: container, fm: fm, tmpDir: self.tmpDir),
                            try self.leafFooter(on: container, fm: fm, tmpDir: self.tmpDir)]
                return bars.flatten(on: container).map {
                    wk.arguments = self.params.flatMap { $0.values }
                    wk.arguments?.append(contentsOf: pageArgs)
                    wk.arguments?.append("-") // output to stdout
                    wk.standardOutput = stdout
                    wk.launch()
                    return stdout.fileHandleForReading.readDataToEndOfFile()
                }
        }
    }
    
    public func set(_ p: GeneralParam) {
        params.append(p)
    }
}

//MARK: Process Leaf Header and Footer

extension WKHTMLTOPDF {
    private func leafHeader(on container: Container, fm: FileManager, tmpDir: String) throws -> Future<Void> {
        if let option = self.params.first(where: { $0.isHeaderLeaf }), let pageBar = option.pageBar {
            if let index = self.params.index(where: { $0.isHeaderHtml }) {
                self.params.remove(at: index)
            }
            return try pageBar.generate(container, fm: fm, tmpDir: tmpDir).map { v in
                self.params.append(.headerHtml(url: v.path))
            }
        }
        return container.eventLoop.newSucceededFuture(result: ())
    }
    
    private func leafFooter(on container: Container, fm: FileManager, tmpDir: String) throws -> Future<Void> {
        if let option = self.params.first(where: { $0.isFooterLeaf }), let pageBar = option.pageBar {
            if let index = self.params.index(where: { $0.isFooterHtml }) {
                self.params.remove(at: index)
            }
            return try pageBar.generate(container, fm: fm, tmpDir: tmpDir).map { v in
                self.params.append(.footerHtml(url: v.path))
            }
        }
        return container.eventLoop.newSucceededFuture(result: ())
    }
}
