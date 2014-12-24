#include "git2/global.h"

/**
 libgit2 uses global state for error handling, among other things.
 Execute this function to initialize libgit2 when Gift is loaded by
 utilizing the `constructor` attribute.
 */
__attribute__((constructor))
static void GiftInitializeLibGit2(void) {
  git_libgit2_init();
}
