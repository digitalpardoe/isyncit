//
//  DPLoginItem.h
//  iSyncIt
//
//	See 'LICENSE' for copyright and licensing.
//

#import <Cocoa/Cocoa.h>

@interface DPLoginItem : NSObject
{
}

+ (BOOL)inLoginItems;

+ (void)removeFromLoginItems;

+ (void)addToLoginItems;

@end
