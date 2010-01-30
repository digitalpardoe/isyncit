//
//  ISI_StartupChecks.h
//  iSyncIt
//
//  Copyright digital:pardoe. All rights reserved.
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
