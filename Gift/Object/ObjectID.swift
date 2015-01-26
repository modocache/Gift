import Foundation
import LlamaKit

/**
  Determine the object ID of the given data via SHA1 hashing.
  The object ID returned would be the ID used if the data were
  written to the object store.

  :param: data The data for which an object ID is to be generated.
  :param: type The type of the object to be written.
  :returns: The result of the hashing operation: either the object ID that would
            be used to store the data to the object store, or a failure indicating
            what went wrong.
*/
internal func objectID(data: NSData, type: ObjectType) -> Result<UnsafeMutablePointer<git_oid>, NSError> {
  var out = UnsafeMutablePointer<git_oid>.alloc(1)
  let errorCode = git_odb_hash(out, data.bytes, UInt(data.length), git_otype(type.rawValue))
  if errorCode == GIT_OK.value {
    return success(out)
  } else {
    return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_odb_hash"))
  }
}

/**
  Determine the object ID of the data at the given file URL via SHA1
  hashing. The object ID returned would be the ID used if the data were
  written to the object store.

  :param: fileURL The URL of the file.
  :param: type The type of the object to be written.
  :returns: The result of the hashing operation: either the object ID that would
            be used to store the data to the object store, or a failure indicating
            what went wrong.
*/
internal func objectID(fileURL: NSURL, type: ObjectType) -> Result<UnsafeMutablePointer<git_oid>, NSError> {
  if let path = fileURL.path {
    var out = UnsafeMutablePointer<git_oid>.alloc(1)
    let errorCode = git_odb_hashfile(out, path, git_otype(type.rawValue))
    if errorCode == GIT_OK.value {
      return success(out)
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_odb_hashfile"))
    }
  } else {
    return failure(NSError.giftError(.InvalidURI, description: "Invalid fileURL: '\(fileURL)'"))
  }
}

/**
  Converts a 40-digit hexadecimal string representation of an object ID
  (a SHA1 hash of the object's contents) to an object ID.

  :param: SHA A string representation of an object ID.
  :returns: The result of the conversion: either a pointer to an objectID, or a failure
            indicating why the SHA string could not be converted.
*/
internal func objectID(SHA: String) -> Result<UnsafeMutablePointer<git_oid>, NSError> {
  var out = UnsafeMutablePointer<git_oid>.alloc(1)
  let errorCode = git_oid_fromstr(out, SHA)
  if errorCode == GIT_OK.value {
    return success(out)
  } else {
    return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_oid_fromstr"))
  }
}

/**
  Converts an object ID (a SHA1 hash of the object's contents) to a 40-digit
  hexadecimal string representation of an object ID.

  :param: objectID The object ID to convert.
  :returns: The result of the conversion: either a string representation of the objectID,
            or a failure indicating why the objectID could not be converted.
*/
internal func objectIDSHA(objectID: UnsafeMutablePointer<git_oid>) -> Result<String, NSError> {
  let cString = git_oid_tostr_s(objectID)
  if let sha = String.fromCString(cString) {
    return success(sha)
  } else {
    let description = "An error occurred when attempting to convert SHA '\(cString)'"
                      + "provided by git_oid_tostr_s to a String."
    return failure(NSError.giftError(.StringConversionFailure, description: description))
  }
}
