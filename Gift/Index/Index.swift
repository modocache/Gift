import LlamaKit

/**
  A data structure representing an index, also referred to as
  a "staging area" for changes. The index is a temporary and
  dynamic binary file that describes the directory structure
  of the entire repository. The index captures a version of the
  project’s overall structure at some moment in time.

  The index allows a separation between incremental developmental
  changes and the committal of those changes. Changes are "staged"
  in an index, keeping those changes until they are ready to be
  committed.
*/
public class Index {
  internal let cIndex: COpaquePointer

  internal init(cIndex: COpaquePointer) {
    self.cIndex = cIndex
  }

  deinit {
    git_index_free(cIndex)
  }
}

public extension Index {
  /**
    Returns the number of entries in the index.
  */
  public var entryCount: UInt {
    return git_index_entrycount(cIndex)
  }

  /**
    Adds the files at the specified paths to the index, using the given options.

    :param: paths Paths, or patterns used to match paths, of the files to be
                  added to the index. If no patterns are specified, all files
                  are added to the index.
    :param: options A set of options for adding files to the index.
    :returns: The result of the operation: either the index to which files have been
              added, or an error indicating what went wrong.
  */
  public func add(paths: [String] = [], options: IndexAddOptions = IndexAddOptions.Default) -> Result<Index, NSError> {
    let count = countElements(paths)
    var cPaths = UnsafeMutablePointer<UnsafeMutablePointer<Int8>>.alloc(count)
    for i in 0..<count {
      cPaths[i] = UnsafeMutablePointer((paths[i] as NSString).UTF8String)
    }

    var stringArray = git_strarray(strings: cPaths, count: UInt(count))
    let errorCode = git_index_add_all(cIndex, &stringArray, UInt32(options.rawValue), nil, nil)
    cPaths.dealloc(count)

    if errorCode == GIT_OK.value {
      return success(self)
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_index_entrycount"))
    }
  }
}
