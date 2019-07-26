import XCTest
@testable import SwiftTableViewGroup

final class SwiftTableViewGroupTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftTableViewGroup().text, "Hello, World!")
        let tableView = TableView {
            
        }
        
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
