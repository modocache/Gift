import XCTest
import Gift

class GiftTests: XCTestCase {
  func testExample() {
    let fileURL = NSURL(fileURLWithPath: "/Users/bgesiak/Desktop/RepositoryTest")
    initializeEmptyRepository(fileURL!, RepositoryOptions())
  }
}
