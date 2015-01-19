import Gift
import LlamaKit
import Quick
import Nimble

class ReferenceSpec: QuickSpec {
  override func spec() {
    var reference: Result<Reference>!

    describe("name") {
      context("when the reference has a valid name") {
        beforeEach {
          reference = openFixturesRepository("ReferenceSpec_Name").flatMap { $0.headReference }
        }
        it("returns a successful result with the reference name") {
          expect(reference.flatMap { $0.name }).to(haveSucceeded("refs/heads/master"))
        }
      }

      xcontext("when the reference doesn't have a valid name") {
        // TODO: Not sure under what conditions this may happen.
        it("returns a failing result") {}
      }
    }
  }
}
