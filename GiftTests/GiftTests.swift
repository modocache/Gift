import XCTest
import Gift
import LlamaKit

let workspacePath = "/private/tmp"
let repoPathString = "\(workspacePath)/RepositoryTest"
let quickPathString = "\(workspacePath)/ClonedQuick"
let quickRepoUrl = "https://github.com/Quick/Quick.git"

class GiftTests: XCTestCase {
  override func setUp() {
    super.setUp()
    system("rm -rf \(repoPathString)")
    system("rm -rf \(quickPathString)")
  }

  override func tearDown() {
    system("rm -rf \(repoPathString)")
    system("rm -rf \(quickPathString)")
    super.tearDown()
  }

  func testRepo() {
    let fileURL = NSURL(fileURLWithPath: repoPathString)
    let repository = initializeEmptyRepository(fileURL!)
    XCTAssert(isSuccessWithValue(
      repository.flatMap { $0.gitDirectoryURL }.map { $0.path! },
      "\(repoPathString)/.git"
    ))

    XCTAssert(isSuccessWithValue(repository.flatMap { $0.index }.map { $0.entryCount }, 0))

    let quickOriginURL = NSURL(string: quickRepoUrl)
    let quickDestURL = NSURL(fileURLWithPath: quickPathString)
    let quickRepo = cloneRepository(quickOriginURL!, quickDestURL!, CloneOptions())

    let unignoredPath = "\(quickRepoUrl)/README.md"
    XCTAssert(isSuccessWithValue(
      quickRepo.flatMap { $0.shouldIgnore(NSURL(fileURLWithPath: unignoredPath)!) },
      false
    ))

    let ignoredPath = "\(quickRepoUrl)/.DS_Store"
    XCTAssert(isSuccessWithValue(
      quickRepo.flatMap { $0.shouldIgnore(NSURL(fileURLWithPath: ignoredPath)!) },
      true
    ))

    let ref = quickRepo.flatMap { $0.headReference }
    XCTAssert(isSuccessWithValue(ref.flatMap { $0.name }, "refs/heads/master"))
    XCTAssert(isSuccessWithValue(ref.map { $0.isRemote }, false))
  }
}
