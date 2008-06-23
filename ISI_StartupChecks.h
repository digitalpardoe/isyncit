/*
 * ISI_StartupChecks.h
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

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
