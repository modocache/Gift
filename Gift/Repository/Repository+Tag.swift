import Foundation
import LlamaKit

public extension Repository {
  /**
    A list of tag names in the repository.

    :param: matchingPattern If a pattern is provided, only the tags
                            matching this pattern are returned.
    :returns: Either a list of tag names matching the given pattern (if any),
              or a failure indicating what went wrong when retrieving the tags.
  */
  public func tagNames(matchingPattern: String = "*") -> Result<[String], NSError> {
    var out = git_strarray(strings: nil, count: 0)
    let errorCode = git_tag_list_match(&out, matchingPattern, cRepository)
    if errorCode == GIT_OK.value {
      var names: [String] = []
      for i in 0..<out.count {
        if let name = String.fromCString(out.strings[Int(i)]) {
          names.append(name)
        } else {
          let description = "An error occurred when attempting to convert tag name \(out.strings[Int(i)]) "
                            + "provided by git_tag_list_match to a String."
          return failure(NSError.giftError(.StringConversionFailure, description: description))
        }
      }
      return success(names)
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_tag_list_match"))
    }
  }
}
