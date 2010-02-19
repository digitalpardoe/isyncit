//
//  ISI_Bluetooth.h
//  iSyncIt
//
//	See 'LICENSE' for copyright and licensing.
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
