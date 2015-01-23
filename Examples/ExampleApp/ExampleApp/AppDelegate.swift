import UIKit
import Gift
import LlamaKit

@UIApplicationMain
public class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow!

  public func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Create a window and set its root view controller.
    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    window.makeKeyAndVisible()

    let rootViewController = UIViewController()
    rootViewController.view.backgroundColor = UIColor.whiteColor()
    window.rootViewController = rootViewController

    // Now the interesting part: clone the libssh2 Git repository.
    let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
    let repo = cloneRepository(
      NSURL(string: "git://git.libssh2.org/libssh2.git")!,
      NSURL(string: documentsDirectory.stringByAppendingPathComponent("Repo"))!
    )

    // Print the directory the Git repository was cloned to.
    println(repo.flatMap { $0.gitDirectoryURL })

    return true
  }
}
