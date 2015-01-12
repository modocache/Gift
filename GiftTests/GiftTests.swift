import XCTest
import Gift
import LlamaKit

class GiftTests: XCTestCase {
  func testExample() {
    let desktopPath = "~/Desktop".stringByExpandingTildeInPath
    let repoPathString = "\(desktopPath)/RepositoryTest"
    let fileURL = NSURL(fileURLWithPath: repoPathString)
    let repository = initializeEmptyRepository(fileURL!, RepositoryOptions())
    AssertSuccess(
      repository.flatMap { $0.gitDirectoryURL }.map { $0.path! },
      "\(repoPathString)/.git"
    )

    AssertSuccess(repository.flatMap { $0.index }.map { $0.entryCount }, 0)

    let quickOriginURL = NSURL(string: "https://github.com/Quick/Quick.git")
    let quickDestURL = NSURL(fileURLWithPath: "\(desktopPath)/ClonedQuick")
    cloneRepository(quickOriginURL!, quickDestURL!, CloneOptions())
  }
}
