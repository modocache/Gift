import UIKit
import XCTest
import ExampleApp

class AppDelegateTests: XCTestCase {
  func testApplicationDidFinishLaunchingWithOptions() {
    let appDelegate = AppDelegate()
    appDelegate.application(UIApplication.sharedApplication(), didFinishLaunchingWithOptions: nil)
  }
}
