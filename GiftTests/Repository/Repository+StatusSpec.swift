import Gift
import LlamaKit
import Quick
import Nimble

class Repository_StatusSpec: QuickSpec {
  override func spec() {
    var repository: Result<Repository, NSError>!
    beforeEach {
      repository = openFixturesRepository("Repository+StatusSpec_AllStatusDeltas")
    }

    describe("status (enumeration)") {
      it("reports each delta") {
        // Arrange: Prepare data structures for storing deltas.
        var headToIndexes = FileDeltas()
        var indexToWorkingDirectories = FileDeltas()

        // Act: Iterate over status deltas, storing them in data structures.
        if repository.isSuccess {
          for deltas in (repository.value!.status().array) {
            headToIndexes.addDelta(deltas.headToIndex)
            indexToWorkingDirectories.addDelta(deltas.indexToWorkingDirectory)
          }
        }

        // Assert: Deltas are correctly reported.
        expect(headToIndexes.deltas).to(equal([
          "head_to_index_added.txt": StatusDeltaType.Added,
          "head_to_index_deleted.txt": StatusDeltaType.Deleted,
          "head_to_index_modified.txt": StatusDeltaType.Modified,
          "head_to_index_modified+index_to_working_directory_modified.txt": StatusDeltaType.Modified,
          "head_to_index_named.txt": StatusDeltaType.Renamed,
        ]))
        expect(indexToWorkingDirectories.deltas).to(equal([
          ".DS_Store": StatusDeltaType.Ignored,
          "index_to_working_directory_ignored.txt": StatusDeltaType.Ignored,
          "index_to_working_directory_modified.txt": StatusDeltaType.Modified,
          "head_to_index_modified+index_to_working_directory_modified.txt": StatusDeltaType.Modified,
          "index_to_working_directory_untracked.txt": StatusDeltaType.Untracked,
        ]))
      }
    }

    describe("status (individual file)") {
      context("when the file doesn't exist") {
        it("returns a failing result") {
          expect(repository.flatMap { $0.status("does-not-exist") })
            .to(haveFailed(domain: libGit2ErrorDomain))
        }
      }

      context("when the file exists and has a single status") {
        it("returns a successful result with that status") {
          expect(repository.flatMap { $0.status("head_to_index_unmodified.txt") })
            .to(haveSucceeded(EntryStatus.Current))
        }
      }

      context("when the file exists and has a set of statuses") {
        it("returns a successful result with multiple statuses") {
          expect(repository.flatMap { $0.status("head_to_index_modified+index_to_working_directory_modified.txt") })
            .to(haveSucceeded(EntryStatus.IndexModified | EntryStatus.WorkingDirectoryModified))
        }
      }
    }

    describe("shouldIgnore") {
      context("when the file doesn't exist") {
        it("returns a successful result with a value of false") {
          expect(repository.flatMap { $0.shouldIgnore("does-not-exist") })
            .to(haveSucceeded(false))
        }
      }

      context("when the file exists and is not ignored") {
        it("returns a successful result with a value of false") {
          expect(repository.flatMap { $0.shouldIgnore("head_to_index_added.txt") })
            .to(haveSucceeded(false))
        }
      }

      context("when the file exists and is ignored") {
        it("returns a successful result with a value of true") {
          expect(repository.flatMap { $0.shouldIgnore("index_to_working_directory_ignored.txt") })
            .to(haveSucceeded(true))
        }
      }
    }
  }
}

// MARK: Test Helpers

private struct FileDeltas {
  private var deltas: [String: StatusDeltaType] = [:]
  private mutating func addDelta(statusDelta: StatusDelta?) {
    if let delta = statusDelta {
      deltas[delta.oldStatus.path] = delta.type
    }
  }
}
