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

    // TODO: Doesn't work--nothing is printed.
    switch quickRepo {
      case .Success(let repoBox):
        let r = repoBox.unbox
        r.status { (headToIndex: StatusDelta, indexToWorkingDirectory: StatusDelta) in
          println(headToIndex.type)
          return false
        }
      case .Failure(let error):
        break
    }

    let ref = quickRepo.flatMap { $0.headReference }
    XCTAssert(isSuccessWithValue(ref.flatMap { $0.name }, "refs/heads/master"))
    XCTAssert(isSuccessWithValue(ref.map { $0.isRemote }, false))
  }

  func testRepositoryOpen() {
    let path = "/Users/bgesiak/GitHub/modocache/Fox"
    let repo = openRepository(NSURL(fileURLWithPath: path)!)
    XCTAssert(isSuccessWithValue(
      repo.flatMap { $0.gitDirectoryURL }.map { $0.path! },
      "\(path)/.git"
    ))
  }
}
