import XCTest
import Gift
import LlamaKit

class GiftTests: XCTestCase {
  func testExample() {
    let fileURL = NSURL(fileURLWithPath: "/Users/bgesiak/Desktop/RepositoryTest")
    let result = initializeEmptyRepository(fileURL!, RepositoryOptions())
    switch result {
      case .Success(let repository):
        XCTAssert(repository.unbox.gitDirectoryURL.isSuccess)
      case .Failure(let _):
        XCTFail("nope")
    }
  }
}
