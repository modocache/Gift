import ReactiveCocoa

internal extension SignalProducer {
  /** Reduces all events in a signal to an array. */
  internal var array: [T] {
    var elements: [T] = []
    start(next: { (element) in
      elements.append(element)
    })
    return elements
  }
}
