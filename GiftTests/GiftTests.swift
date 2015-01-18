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
    let repository = initializeEmptyRepository(
      NSURL(fileURLWithPath: repoPathString)!,
      RepositoryInitializationOptions(
        optionsSet: RepositoryInitializationOptionSet.MakePath,
        mode: .User
      )
    )
    XCTAssert(isSuccessWithValue(
      repository.flatMap { $0.gitDirectoryURL }.map { $0.path! },
      "\(repoPathString)/.git"
    ))

    XCTAssert(isSuccessWithValue(repository.flatMap { $0.index }.map { $0.entryCount }, 0))

    let quickRepo = cloneRepository(
      NSURL(string: quickRepoUrl)!,
      NSURL(fileURLWithPath: quickPathString)!,
      CloneOptions(
        checkoutOptions: CheckoutOptions(strategy: CheckoutStrategy.SafeCreate),
        remoteCallbacks: RemoteCallbacks()
      )
    )

    XCTAssert(isSuccessWithValue(
      quickRepo.flatMap { $0.shouldIgnore("\(quickRepoUrl)/README.md") },
      false
    ))
    XCTAssert(isSuccessWithValue(
      quickRepo.flatMap { $0.shouldIgnore("\(quickRepoUrl)/.DS_Store") },
      true
    ))

    XCTAssert(isSuccessWithValue(
      quickRepo.flatMap { $0.status("README.md") },
      Status.Current
    ))

    system("echo 'test working tree modified' > \(quickPathString)/README.md")
    XCTAssert(isSuccessWithValue(
      quickRepo.flatMap { $0.status("README.md") },
      Status.WorkingDirectoryModified
    ))

    let ref = quickRepo.flatMap { $0.headReference }
    XCTAssert(isSuccessWithValue(ref.flatMap { $0.name }, "refs/heads/master"))
    XCTAssert(isSuccessWithValue(ref.map { $0.isRemote }, false))

    var headToIndexes: [StatusDelta] = []
    var indexToWorkingDirectories: [StatusDelta] = []
    quickRepo.flatMap { $0.status { (headToIndex: StatusDelta?, indexToWorkingDirectory: StatusDelta?) in
      if let h = headToIndex {
        headToIndexes.append(h)
      }
      if let i = indexToWorkingDirectory {
        indexToWorkingDirectories.append(i)
      }
      return false
    }}
    XCTAssertEqual(countElements(headToIndexes), 0)
    XCTAssertEqual(countElements(indexToWorkingDirectories), 1)
  }
}
