# Gift

[![Build
Status](https://travis-ci.org/modocache/Gift.svg)](https://travis-ci.org/modocache/Gift)

Gift provides Swift bindings to the
[libgit2](https://github.com/libgit2/libgit2) library.

That means you can clone a Git repository, list its commits,
or even make a commit of your own--all from within your Swift
program.

For example, we can grab the latest commit message of *this*
repository:

```swift
let url = NSURL(fileURLWithPath: "/Users/modocache/Gift")!
let latestCommitMessage = openRepository(url)
  .flatMap { $0.headReference }
  .flatMap { $0.commit }
  .flatMap { $0.message }
```

Gift returns result objects for any operation that might fail. The type
of `lastCommitMessage` above is `Result<String, NSError>`. If every
operation succeeded, you can access the commit message `String`. But if
any of the operations failed, you'll have an `NSError` that describes
what went wrong.

# Features

You can list all branches in a repository. Gift uses ReactiveCocoa to
represent a sequence of values:

```swift
repository.branches().start(next: { (reference) in
  println("Branch name: \(reference.name)")
})
```

You can list commits as well:

```swift
repository.commits().start { (commit) in
  println("Commit message: \(commit.message)")
}
```

You can order the commits as you please, of course:

```swift
let commits = repository.commits(sorting: CommitSorting.Time | CommitSorting.Reverse)
```

You can *make* a commit, too:

```swift
let tree = repository.index        // Grab the index for the repository
  .flatMap { $0.add() }            // Add any modified entries to that index
  .flatMap { $0.writeTree() }      // Grab a tree representing the changeset
  .flatMap { $0.commit("Zing!") }  // Commit
```

Swift allows Gift to provide default parameters. If you want to use the
default behavior, you can easily clone a remote repository:

```swift
let remoteURL = NSURL(string: "git://git.libssh2.org/libssh2.git")!
let destinationURL = NSURL(fileURLWithPath: "/Users/modocache/libssh2")!
let repository = cloneRepository(remoteURL, destinationURL)
```

But you can also customize that behavior and have Gift issue download
progress updates:

```swift
let options = CloneOptions(
  checkoutOptions: CheckoutOptions(
    strategy: CheckoutStrategy.SafeCreate,
    progressCallback: { (path, completedSteps, totalSteps) in
      // ...do something with checkout progress.
    }
  ),
  remoteCallbacks: RemoteCallbacks(
    transportMessageCallback: { (message) in
      // ...do something with messages from remote, like "Compressing objects: 1% (47/4619)"
    },
    transferProgressCallback: { (progress) in
      // ...do something with progress (bytes received, etc.) updates.
    })
)
let repository = cloneRepository(remoteURL, destinationURL, options: options)
```

# How to Build

You'll need to have [homebrew](https://github.com/Homebrew/homebrew/)
installed. If you don't already have CMake installed, run:

```
$ brew install cmake
```

Then, to build the dependencies for Gift, just run:

```
$ rake dependencies build
```

If it's your first time running the script, it'll take a while--it
needs to build static libraries for OpenSSL, libssh2, and libgit2.
And that's for both OS X _and_ iOS.

## Testing Your Changes

You can test your changes by running:

```
$ rake
```

## Build Errors

If you see a non-descript error like "Cannot build module Gift", there's
an extremely sophisticated workaround: first, remove all the source files from
the main and test target you're trying to build.

![](https://s3.amazonaws.com/f.cl.ly/items/0M0V1y07081s2W34412w/Screen%20Shot%202015-01-22%20at%2010.09.29%20PM.png)

Then, build the framework. It should work fine (magic, I know). Now that
it builds, revert the removal of the files by running
`git checkout -- Gift.xcodeproj`. And voila! Now everything builds fine.

# How to Use Gift in Your iOS App

You can find an example iOS app that uses Gift in the
[`Examples`](https://github.com/Quick/Quick/tree/master/Examples) directory. Using Gift
is (sort of) easy:

1. Drag `Gift.xcodeproj`, `LlamaKit.xcodeproj`, `Quick.xcodeproj`, and
   `Nimble.xcodeproj` into your app's workspace.
2. In the "Link Binary with Libraries" build phase of your app, link
   your app to Gift.framework.
3. Set the “Header Search Paths” (`HEADER_SEARCH_PATHS`) build setting to
   the correct path for the libgit2 headers in your project. For
   example, if you added the submodule to your project as
   `External/Gift`, you would set this build setting to
   `External/Gift/External/libgit2/include`.
4. `import Gift` in any Swift file, and you're off to the races!

