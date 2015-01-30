#import "GIFTTagForEach.h"
#import <git2/tag.h>

const int GIFTTagForEachCallbackPayloadError = -1988;

static int gift_tagForEachCallback(const char *cName, git_oid *oid, void *payload) {
  if (payload == NULL) {
    return GIFTTagForEachCallbackPayloadError;
  }

  NSString *name = nil;
  if (cName != NULL) {
    name = @(cName);
  }

  GIFTTagForEachCallback block = (__bridge GIFTTagForEachCallback)payload;
  return block(name, oid);
}

int gift_tagForEach(git_repository *repository,
                    GIFTTagForEachCallback tagCallback) {
  return git_tag_foreach(repository,
                         gift_tagForEachCallback,
                         (__bridge void *)[tagCallback copy]);
}
