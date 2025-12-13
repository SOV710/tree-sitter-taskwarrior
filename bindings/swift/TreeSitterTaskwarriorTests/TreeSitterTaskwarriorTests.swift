import XCTest
import SwiftTreeSitter
import TreeSitterTaskwarrior

final class TreeSitterTaskwarriorTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_taskwarrior())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading Taskwarrior grammar")
    }
}
