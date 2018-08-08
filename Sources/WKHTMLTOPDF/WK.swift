import Foundation
import Core
import Vapor
import Leaf

public typealias WK = WKHTMLTOPDF

public class WKHTMLTOPDF {
    private var params: [GeneralParam] = []
    #if os(Linux)
    private var pathToBinary = "/usr/bin/wkhtmltopdf"
    #else
    private var pathToBinary = "/usr/local/bin/wkhtmltopdf"
    #endif
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
        }.map {
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
            defer {
                stdout.fileHandleForReading.closeFile()
            }
            wk.launchPath = self.pathToBinary
            if !self.params.contains(.quiet()) {
                self.params.append(.quiet())
            }
            wk.arguments = self.params.flatMap { $0.values }
            wk.arguments?.append(contentsOf: pageArgs)
            wk.arguments?.append("-") // output to stdout
            wk.standardOutput = stdout
            wk.launch()
            return stdout.fileHandleForReading.readDataToEndOfFile()
        }
    }
    
}
