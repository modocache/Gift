# Gift

Gift provides Swift bindings to the
[libgit2](https://github.com/libgit2/libgit2) library. It's a work in
progress!

# How to Build

Before you can build the project and run the tests, you'll need to
follow the build instructions for each platform.

## iOS

```
$ git submodule update --init recursive
$ rake build:ios:libssh2 build:ios:libgit2
```

## OS X

First, pull down all the submodules:

```
$ git submodule update --init --recursive
```

`Gift-OSX` links libgit2.a as part of its build process.
You'll need to build libgit2 in order to create the static library at
the expected path.

In order to build libgit2, `cmake` is required.

```
$ brew install cmake
```

With `cmake` installed, run the following commands:

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

