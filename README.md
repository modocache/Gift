# Gift

Gift provides Swift bindings to the
[libgit2](https://github.com/libgit2/libgit2) library. It's a work in
progress!

# How to Build

You'll need to have [homebrew](https://github.com/Homebrew/homebrew/)
installed, then just run:

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

