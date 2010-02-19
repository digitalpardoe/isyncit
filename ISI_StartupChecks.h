//
//  ISI_StartupChecks.h
//  iSyncIt
//
//	See 'LICENSE' for copyright and licensing.
//

#import <Cocoa/Cocoa.h>

@interface ISI_StartupChecks : NSObject
{
}

+ (void)startupChecks;

+ (void)_bluetoothCheck;

+ (void)_updateCheck;

+ (void)_donateCheck;

+ (void)_lastSyncCheck;

@end
