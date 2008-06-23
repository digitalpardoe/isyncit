//
//  DPLoginItem.h
//  iSyncIt
//
//  Created by Alex on 05/06/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DPLoginItem : NSObject
{
}

+ (BOOL)inLoginItems;

+ (void)removeFromLoginItems;

+ (void)addToLoginItems;

@end
