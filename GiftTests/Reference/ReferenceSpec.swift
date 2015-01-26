import Gift
import LlamaKit
import Quick
import Nimble

class ReferenceSpec: QuickSpec {
  override func spec() {
    var reference: Result<Reference, NSError>!
    beforeEach {
      reference = openFixturesRepository("Spec_EmptyRepository").flatMap { $0.headReference }
    }

    describe("name") {
      context("when the reference has a valid name") {
        it("returns a successful result with the reference name") {
          expect(reference.flatMap { $0.name }).to(haveSucceeded("refs/heads/master"))
        }
      }

      xcontext("when the reference doesn't have a valid name") {
        // TODO: Not sure under what conditions this may happen.
        it("returns a failing result") {}
      }
    }

    describe("SHA") {
      it("returns the SHA") {
        expect(reference.flatMap { $0.SHA })
          .to(haveSucceeded("8dcbbd29ec495e2dbcaa8f97e9a31af9cb4ae7cd"))
      }
    }
  }
}
