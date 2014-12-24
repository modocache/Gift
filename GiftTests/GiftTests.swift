import XCTest
import Gift
import LlamaKit

class GiftTests: XCTestCase {
  func testExample() {
    let fileURL = NSURL(fileURLWithPath: "/Users/bgesiak/Desktop/RepositoryTest")
    let path = initializeEmptyRepository(fileURL!, RepositoryOptions())
      .flatMap { $0.gitDirectoryURL }
      .map { $0.path! }
    AssertSuccess(path, "/Users/bgesiak/Desktop/RepositoryTest/.git")
  }
}
