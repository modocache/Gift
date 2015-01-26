import Foundation
import Gift
import LlamaKit

/**
  Creates a directory in the user's temporary directory.

  :returns: The URL of the newly created directory, or nil if the directory
            could not be created. Since failing to create a temporary
            directory represents a fatal error for the test suite, no attempt
            is made to recover from such a condition; the URL is unwrapped
            when accessed and the test suite will crash.
*/
internal func temporaryDirectoryURL() -> NSURL! {
  let tempDirectoryPath = NSTemporaryDirectory()
    .stringByAppendingPathComponent("com.libgit2.gift")
    .stringByAppendingPathComponent(NSProcessInfo.processInfo().globallyUniqueString)

  var error: NSError?
  NSFileManager.defaultManager()
    .createDirectoryAtPath(tempDirectoryPath, withIntermediateDirectories: true, attributes: nil, error: &error)

  if error == nil {
    return NSURL(fileURLWithPath: tempDirectoryPath)!
  } else {
    return nil
  }
}

/**
  Unzips the test fixture repositories directory and opens the repository
  with the given name.

  :param: name The name of the repository to open. This should be a directory on the top level
               of "GiftTests/Fixtures/Fixtures.zip".
  :returns: The result of opening the repository: either a Repository object, or a failure
            indicating what went wrong.
*/
internal func openFixturesRepository(name: String) -> Result<Repository, NSError> {
  let source = NSBundle(forClass: TestBundleLocator.classForCoder()).pathForResource("Fixtures", ofType: "zip")
  let destination = temporaryDirectoryURL()

  // system() and NSTask() are not available when running tests in
  // the iOS simulator, so we use zlib (wrapped by Sam Soffes) directly
  // instead of shelling out to /usr/bin/zip.
  SSZipArchive.unzipFileAtPath(source!, toDestination: destination.path!)

  return openRepository(destination
    .URLByAppendingPathComponent("Fixtures")
    .URLByAppendingPathComponent(name))
}

/**
  A class used to locate the test bundle. Used by the openFixturesRepository() function.
*/
private class TestBundleLocator: NSObject {}
