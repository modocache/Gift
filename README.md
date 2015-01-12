# Gift

Gift provides Swift bindings to the
[libgit2](https://github.com/libgit2/libgit2) library. It's a work in
progress!

# How to Build

## 1. Create a Module for libgit2

In order to make the C functions and data structures in libgit2
available to Swift, create the following file at the submodule path
`External/libgit2`:

```
# External/libgit2/module.map

module git2 [system] {
  header "include/git2.h"
  export *
}
```

This exposes all the headers in `External/libgit2/include/git2.h` to
Swift. Gift picks up on this module map because `Gift.xcodeproj` adds
`External/libgit2` to `Swift Compiler - Search Paths > Import Paths`.

To see an example of how to use those headers, see
`Gift/Repository.swift`. It's not pretty!

## 2. Build libgit2 for Linking

`Gift.xcodeproj` links the libgit2.dylib as part of its build process.
You'll need to build libgit2 in order to create the dylib at the expected path:

```
$ cd External/libgit2
$ mkdir build
$ cd build
$ cmake ..
$ cmake --build .
```
