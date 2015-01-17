import LlamaKit
import XCTest

internal func isSuccessWithValue<T: Equatable>(result: Result<T>, value: T) -> Bool {
  switch result {
  case .Success(let box):
    return box.unbox == value
  case .Failure(let error):
    return false
  }
}
