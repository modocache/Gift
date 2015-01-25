import Gift
import LlamaKit
import Quick
import Nimble

class Reference_TagSpec: QuickSpec {
  override func spec() {
    var repository: Result<Repository>!
    var reference: Result<Reference>!
    beforeEach {
      repository = openFixturesRepository("Spec_EmptyRepository")
      reference = repository.flatMap { $0.headReference }
    }

    describe("tag") {
      it("creates an annotated tag with the given name") {
        expect(reference.flatMap { $0.tag(
          "carroll-gardens",
          message: "bushwick",
          signature: Signature(name: "dumbo", email: "bedford-stuyvesant")
        ) }.flatMap { $0.name }).to(haveSucceeded("carroll-gardens"))
      }
    }
  }
}
