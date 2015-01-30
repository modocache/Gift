#import <Foundation/Foundation.h>

typedef struct git_oid git_oid;
typedef struct git_repository git_repository;

extern const int GIFTTagForEachCallbackPayloadError;

/**
 A callback function that is executed for each tag in the repository.

 @param referenceName The name of the tag.
 @param referenceObjectID A pointer to the object ID of the tag.
 @return An integer representing whether tag enumeration should continue.
         Anything but zero will halt enumeration. If enumeration is
         halted, the result code of the tag enumeration function will
         be equal to any non-zero value returned here.
 */
typedef int (^GIFTTagForEachCallback)(NSString *referenceName,
                                      git_oid *referenceObjectID);

/**
 Enumerates over all tags in a repository. Used internally by Gift.

 @param repository A pointer to a C struct used to represent a repository by libgit2.
 @param tagCallback A callback, which may be defined in Swift, that will be passed
                    to a static C callback function.
 @return A status code. Anything other than 0 will halt the tag enumeration.
 */
extern int gift_tagForEach(git_repository *repository,
                           GIFTTagForEachCallback tagCallback);
