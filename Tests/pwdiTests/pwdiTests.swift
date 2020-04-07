import XCTest
@testable import pwdi

final class pwdiTests: XCTestCase {
    func testExample() {
        XCTAssertEqual(pwdi().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
