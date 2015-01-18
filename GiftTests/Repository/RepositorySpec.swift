import Gift
import Quick
import Nimble
import LlamaKit

public func beSuccessful<T>() -> MatcherFunc<Result<T>> {
  return MatcherFunc { actualExpression, failureMessage in
    failureMessage.postfixMessage = "be successful"
    if let result = actualExpression.evaluate() {
      return result.isSuccess
    } else {
      return false
    }
  }
}

public func beSuccessful<T: Equatable>(value: T) -> MatcherFunc<Result<T>> {
  return MatcherFunc { actualExpression, failureMessage in
    failureMessage.postfixMessage = "be successful with a value of \(value)"
    if let result = actualExpression.evaluate() {
      switch result {
        case .Success(let box):
          return box.unbox == value
        case .Failure:
          return false
      }
    } else {
      return false
    }
  }
}

class RepositorySpec: QuickSpec {
  override func spec() {
    var tempDirectoryURL: NSURL!
    beforeEach {
      let tempDirectoryPath = NSTemporaryDirectory()
        .stringByAppendingPathComponent("com.libgit2.gift")
        .stringByAppendingPathComponent(NSProcessInfo.processInfo().globallyUniqueString)

      var error: NSError?
      NSFileManager.defaultManager()
        .createDirectoryAtPath(tempDirectoryPath, withIntermediateDirectories: true, attributes: nil, error: &error)
      expect(error).to(beNil())

      tempDirectoryURL = NSURL(fileURLWithPath: tempDirectoryPath)!
    }

    describe("initializeEmptyRepository") {
      context("with default settings") {
        beforeEach {
          // TODO: Removing this initialization (unused) causes references to
          //       RepositoryInitializationOptions() to segfault.
          let _ = RepositoryInitializationOptions(
            optionsSet: RepositoryInitializationOptionSet.MakePath,
            mode: .User
          )
        }

        it("initializes a repository with a working directory") {
          let newRepoURL = tempDirectoryURL.URLByAppendingPathComponent("greenpoint")
          let repository = initializeEmptyRepository(newRepoURL)
          expect(repository.flatMap { $0.gitDirectoryURL }.map { $0.path!.stringByResolvingSymlinksInPath })
            .to(beSuccessful(newRepoURL.URLByAppendingPathComponent(".git").path!.stringByResolvingSymlinksInPath))
        }
      }
    }
  }
}
