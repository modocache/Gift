internal func errorMessage(errorCode: Int32) -> String? {
  let last = giterr_last()
  if last != nil {
    return String.fromCString(last.memory.message)
  } else if UInt32(errorCode) == GITERR_OS.value {
    return String.fromCString(strerror(errno))
  } else {
    return nil
  }
}
