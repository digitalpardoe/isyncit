//
//  DPLoginItem.h
//  iSyncIt
//

#import <Cocoa/Cocoa.h>

@interface DPLoginItem : NSObject
{
}

+ (BOOL)inLoginItems;

+ (void)removeFromLoginItems;

+ (void)addToLoginItems;

@end
