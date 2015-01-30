import LlamaKit

/**
  Given an array of results, return an array of successful values,
  discarding any results that were unsuccessful.
*/
internal func compact<T, U>(results: [Result<T, U>]) -> [T] {
  var compacted: [T] = []
  results.map { $0.map { compacted.append($0) } }
  return compacted
}
