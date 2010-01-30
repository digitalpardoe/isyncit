//
//  DPLoginItem.h
//  iSyncIt
//
//  Copyright digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DPLoginItem : NSObject
{
}

+ (BOOL)inLoginItems;

+ (void)removeFromLoginItems;

+ (void)addToLoginItems;

@end
