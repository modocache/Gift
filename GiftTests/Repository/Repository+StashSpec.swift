import Foundation
import Gift
import ReactiveCocoa
import LlamaKit
import Quick
import Nimble

class Repository_StashSpec: QuickSpec {
  override func spec() {
    var repository: Result<Repository, NSError>!
    beforeEach {
      repository = openFixturesRepository("Repository+StashSpec_TwoFilesInIndex")
    }

    describe("creating a stash") {
      it("it creates a stash when files are staged") {
        let index = repository.flatMap { $0.index }
        let entryCount = index.map { $0.entryCount }
        expect(entryCount).to(haveSucceeded(2))

        repository.map { $0.stash("Boom Shaka-Lakka, # 1 Chief Rocca") }

        expect(index.map { $0.entryCount }).to(haveSucceeded(0))
      }
    }
  }
}
