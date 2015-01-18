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
