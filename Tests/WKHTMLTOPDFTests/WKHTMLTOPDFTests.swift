import XCTest
@testable import WKHTMLTOPDF

final class WKHTMLTOPDFTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(WKHTMLTOPDF().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
