import Foundation
import LlamaKit

/**
  Converts each of the strings in a git_strarray to a Swift string,
  then returns a list of those strings. If any of the strings cannot
  be converted, returns an error indicating what went wrong.
  Used internally by Gift.
*/
internal func strings(gitStrArray: git_strarray) -> Result<[String], NSError> {
  var allStrings: [String] = []
  for i in 0..<gitStrArray.count {
    if let string = String.fromCString(gitStrArray.strings[Int(i)]) {
      allStrings.append(string)
    } else {
      let description = "An error occurred when attempting to convert string '\(gitStrArray.strings[Int(i)])' "
                        + "in git_strarray to a String."
      return failure(NSError.giftError(.StringConversionFailure, description: description))
    }
  }
  return success(allStrings)
}