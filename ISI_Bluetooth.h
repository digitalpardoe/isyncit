//
//  ISI_Bluetooth.h
//  iSyncIt
//
//  Copyright digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ISI_Bluetooth : NSObject
{
}

+ (void)setPowerState:(int)state;

+ (int)getPowerState;

+ (void)togglePowerState;

+ (BOOL)available;

+ (void)_message;

@end
