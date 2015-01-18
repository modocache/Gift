# Gift

Gift provides Swift bindings to the
[libgit2](https://github.com/libgit2/libgit2) library. It's a work in
progress!

# How to Build

`Gift.xcodeproj` links the libgit2.dylib as part of its build process.
You'll need to build libgit2 in order to create the dylib at the expected path:

```
$ cd External/libgit2
$ mkdir build
$ cd build
$ cmake ..
$ cmake --build .
```
