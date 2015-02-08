import Nimble
import LlamaKit

public func haveSucceeded<T>() -> MatcherFunc<Result<T, NSError>> {
  return MatcherFunc { actualExpression, failureMessage in
    failureMessage.postfixMessage = "have succeeded"
    if let result = actualExpression.evaluate() {
      return result.isSuccess
    } else {
      return false
    }
  }
}

public func haveSucceeded<T: Equatable>(value: T) -> MatcherFunc<Result<T, NSError>> {
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

public func haveFailed<T>(domain: String? = nil, localizedDescription: String? = nil) -> MatcherFunc<Result<T, NSError>> {
  return MatcherFunc { actualExpression, failureMessage in
    failureMessage.postfixMessage = "have failed"
    if let result = actualExpression.evaluate() {
      switch result {
      case .Success:
        return false
      case .Failure(let error):
        var allEqualityChecksAreTrue = true
        if let someDomain = domain {
          failureMessage.postfixMessage = "\(failureMessage.postfixMessage), with a domain of '\(someDomain)'"
          allEqualityChecksAreTrue = allEqualityChecksAreTrue && error.unbox.domain == someDomain
        }
        if let description = localizedDescription {
          failureMessage.postfixMessage = "\(failureMessage.postfixMessage), with the description '\(description)'"
          allEqualityChecksAreTrue = allEqualityChecksAreTrue && error.unbox.localizedDescription == description
        }
        return allEqualityChecksAreTrue
      }
    } else {
      return false
    }
  }
}
