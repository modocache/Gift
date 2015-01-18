# Gift

Gift provides Swift bindings to the
[libgit2](https://github.com/libgit2/libgit2) library. It's a work in
progress!

# How to Build

`Gift.xcodeproj` links libgit2.a as part of its build process.
You'll need to build libgit2 in order to create the static library at
the expected path:

```
$ cd External/libgit2
$ mkdir build
$ cd build
$ cmake -DBUILD_SHARED_LIBS:BOOL=OFF -DBUILD_CLAR:BOOL=OFF -DTHREADSAFE:BOOL=ON ..
$ cmake --build .
```

You'll also need the latest version of libssh2:

```
$ brew install libssh2
$ brew upgrade libssh2
```
