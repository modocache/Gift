import Nimble
import LlamaKit

public func haveSucceeded<T>() -> MatcherFunc<Result<T>> {
  return MatcherFunc { actualExpression, failureMessage in
    failureMessage.postfixMessage = "have succeeded"
    if let result = actualExpression.evaluate() {
      return result.isSuccess
    } else {
      return false
    }
  }
}

public func haveSucceeded<T: Equatable>(value: T) -> MatcherFunc<Result<T>> {
  return MatcherFunc { actualExpression, failureMessage in
    failureMessage.postfixMessage = "have succeeded with a value of \(value)"
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

public func haveFailed<T>(domain: String? = nil, localizedDescription: String? = nil) -> MatcherFunc<Result<T>> {
  return MatcherFunc { actualExpression, failureMessage in
    failureMessage.postfixMessage = "have failed with a localized description of \(localizedDescription)"
    if let result = actualExpression.evaluate() {
      switch result {
      case .Success:
        return false
      case .Failure(let llamaKitError):
        if let error = llamaKitError as? NSError {
          var allEqualityChecksAreTrue = true
          if let someDomain = domain {
            allEqualityChecksAreTrue = allEqualityChecksAreTrue && error.domain == someDomain
          }
          if let description = localizedDescription {
            allEqualityChecksAreTrue = allEqualityChecksAreTrue && error.localizedDescription == description
          }
          return allEqualityChecksAreTrue
        } else {
          return false
        }
      }
    } else {
      return false
    }
  }
}
