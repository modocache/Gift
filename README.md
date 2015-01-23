# Gift

Gift provides Swift bindings to the
[libgit2](https://github.com/libgit2/libgit2) library. It's a work in
progress!

# How to Build

You'll need to have [homebrew](https://github.com/Homebrew/homebrew/)
installed, then just run:

```
$ rake
```

If it's your first time running the script, it'll take a while--it
needs to build static libraries for OpenSSL, libssh2, and libgit2.
And that's for both OS X _and_ iOS.

