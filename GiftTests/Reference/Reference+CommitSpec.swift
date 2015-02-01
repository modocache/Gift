import Gift
import LlamaKit
import Quick
import Nimble

class Reference_CommitSpec: QuickSpec {
  override func spec() {
    var repository: Result<Repository, NSError>!
    var reference: Result<Reference, NSError>!
    beforeEach {
      repository = openFixturesRepository("Spec_EmptyRepository")
      reference = repository.flatMap { $0.headReference }
    }

    describe("commit") {
      it("returns the commit the reference is referring to") {
        expect(reference.flatMap { $0.commit }.flatMap { $0.message }).to(haveSucceeded("Initial commit.\n"))
      }
    }
  }
}
