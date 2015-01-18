import Foundation

public func temporaryDirectoryURL() -> NSURL! {
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
