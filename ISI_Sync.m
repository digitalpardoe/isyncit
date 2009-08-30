/*
 * ISI_Sync.m
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import "ISI_Sync.h"

@implementation ISI_Sync

+ (void)startSync:(BOOL)defaultsValue
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:[NSDate date] forKey:@"ISI_LastSync"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	int currentStatus = 0;
	
	if ([ISI_Bluetooth available]) {
		if (defaultsValue == TRUE) {
			currentStatus = [ISI_Bluetooth getPowerState];
			if (currentStatus == 0) {
				[ISI_Bluetooth setPowerState:1];
			}
		}
	}
	
	NSString *syncNowString = @"tell application \"iSync\"\r if not (synchronize) then\r else\r repeat while (syncing is true)\r delay 5\r end repeat\r quit\r end if\r end tell";
	NSAppleScript *syncNowScript = [[NSAppleScript alloc] initWithSource:syncNowString];
	[syncNowScript executeAndReturnError:nil];
	[syncNowScript release];
	
	if ([ISI_Bluetooth available]) {
		if (defaultsValue == TRUE) {
			if (currentStatus == 0) {
				[ISI_Bluetooth setPowerState:0];
			}
		}
	}
	
	[[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"uk.co.digitalpardoe.iSyncIt.updateMenu" object:nil];
	[[DPGrowl theGrowl] showGrowlNotification : @"Sync Complete" : @"Sync Complete" : @"Synchronization of your devices has been completed."];
}

@end