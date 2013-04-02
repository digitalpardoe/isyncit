/*
 * ISI_StartupChecks.m
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import "ISI_StartupChecks.h"

@implementation ISI_StartupChecks

int startupChecks()
{
	bluetoothCheck();
	updateCheck();
}

int bluetoothCheck()
{
	NSNumber *bluetoothSyncing = [[NSUserDefaults standardUserDefaults] objectForKey:@"ISI_EnableBluetooth"];
	if (!bluetoothSyncing)
	{
		bluetoothSyncing = [NSNumber numberWithBool:NSRunAlertPanel(@"Enable automatic bluetooth control?", [NSString stringWithFormat:@"Would you like bluetooth to be automatically controlled by iSyncIt during syncing?"], @"Enable", @"Don't Enable", nil) == NSAlertDefaultReturn];
		[[NSUserDefaults standardUserDefaults] setObject:bluetoothSyncing forKey:@"ISI_EnableBluetooth"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	
	[bluetoothSyncing release];
}

int updateCheck()
{
	NSNumber *updateChecking = [[NSUserDefaults standardUserDefaults] objectForKey:@"SUCheckAtStartup"];
	if (!updateChecking)
	{
		updateChecking = [NSNumber numberWithBool:NSRunAlertPanel(@"Check for updates on startup?", [NSString stringWithFormat:@"Would you like iSyncIt to check for updates on startup? If not, you can initiate the check manually from the application menu"], @"Yes", @"No", nil) == NSAlertDefaultReturn];
		[[NSUserDefaults standardUserDefaults] setObject:updateChecking forKey:@"SUCheckAtStartup"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	
	[updateChecking release];
}

@end
