//
//  ISI_Bluetooth.h
//  iSyncIt
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
