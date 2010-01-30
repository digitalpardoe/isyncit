//
//  DPGrowl.h
//  iSyncIt
//
//  Copyright digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Growl/Growl.h>

@interface DPGrowl : NSObject <GrowlApplicationBridgeDelegate>
{
}

+ (DPGrowl *)theGrowl;

- (void)initializeGrowl;

- (void)showGrowlNotification:(NSString *)growlName:(NSString *)growlTitle:(NSString *)gowlDescription;

@end
