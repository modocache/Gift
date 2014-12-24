import LlamaKit
import XCTest

internal func AssertSuccess<T: Equatable>(result: Result<T>, value: T) {
  switch result {
    case .Success(let box):
      XCTAssertEqual(box.unbox, value)
    case .Failure(let error):
      XCTFail("Result was unsuccessful: \(error)")
  }
}
