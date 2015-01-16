import XCTest
import Gift
import LlamaKit

var workspacePath = "/private/tmp"
var repoPathString = "\(workspacePath)/RepositoryTest"
var quickPathString = "\(workspacePath)/ClonedQuick"
var quickRepoUrl = "https://github.com/Quick/Quick.git"

class GiftTests: XCTestCase {
  override func tearDown() {
    system("rm -rf \(repoPathString)")
    system("rm -rf \(quickPathString)")
  }

  func testRepo() {
    let fileURL = NSURL(fileURLWithPath: repoPathString)
    let repository = initializeEmptyRepository(fileURL!)
    AssertSuccess(
      repository.flatMap { $0.gitDirectoryURL }.map { $0.path! },
      "\(repoPathString)/.git"
    )

    AssertSuccess(repository.flatMap { $0.index }.map { $0.entryCount }, 0)

    let quickOriginURL = NSURL(string: quickRepoUrl)
    let quickDestURL = NSURL(fileURLWithPath: quickPathString)
    let quickRepo = cloneRepository(quickOriginURL!, quickDestURL!, CloneOptions())
    let ref = quickRepo.flatMap { $0.headReference }
    AssertSuccess(ref.flatMap { $0.name }, "refs/heads/master")
    AssertSuccess(ref.map { $0.isRemote }, false)
  }
}
