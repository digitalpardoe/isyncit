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
	moveOldPrefs();

	lastSyncCheck();
	bluetoothCheck();
	updateCheck();
	iconCheck();
	donateCheck();
}

int moveOldPrefs()
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	[fileManager movePath:@"~/Library/Preferences/co.uk.digitalpardoe.iSyncIt.plist" toPath:@"~/Library/Preferences/uk.co.digitalpardoe.iSyncIt.plist" handler:nil];
}

int bluetoothCheck()
{
	NSNumber *bluetoothSyncing = [[NSUserDefaults standardUserDefaults] objectForKey:@"ISI_EnableBluetooth"];
	if (!bluetoothSyncing) {
		bluetoothSyncing = [NSNumber numberWithBool:NSRunAlertPanel(NSLocalizedString(@"Enable automatic bluetooth control?", nil), [NSString stringWithFormat:NSLocalizedString(@"Would you like bluetooth to be automatically controlled by iSyncIt during syncing?", nil)], NSLocalizedString(@"Enable", nil), NSLocalizedString(@"Don't Enable", nil), nil) == NSAlertDefaultReturn];
		[[NSUserDefaults standardUserDefaults] setObject:bluetoothSyncing forKey:@"ISI_EnableBluetooth"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	
	[bluetoothSyncing release];
}

int updateCheck()
{
	NSNumber *updateChecking = [[NSUserDefaults standardUserDefaults] objectForKey:@"SUCheckAtStartup"];
	if (!updateChecking) {
		updateChecking = [NSNumber numberWithBool:NSRunAlertPanel(NSLocalizedString(@"Check for updates on startup?", nil), [NSString stringWithFormat:NSLocalizedString(@"Would you like iSyncIt to check for updates on startup? If not, you can initiate the check manually from the application menu", nil)], NSLocalizedString(@"Yes", nil), NSLocalizedString(@"No", nil), nil) == NSAlertDefaultReturn];
		[[NSUserDefaults standardUserDefaults] setObject:updateChecking forKey:@"SUCheckAtStartup"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	
	[updateChecking release];
}

int iconCheck()
{
	NSNumber *iconChecking = [[NSUserDefaults standardUserDefaults] objectForKey:@"ISI_AlternateMenuBarItem"];
	if (!iconChecking) {
		iconChecking = [NSNumber numberWithBool:NSRunAlertPanel(NSLocalizedString(@"Use alternate menu bar icon?", nil), [NSString stringWithFormat:NSLocalizedString(@"Would you like to use the alternate (colourful) menu bar icon?", nil)], NSLocalizedString(@"Alternate Icon", nil), NSLocalizedString(@"Original Icon", nil), nil) == NSAlertDefaultReturn];
		[[NSUserDefaults standardUserDefaults] setObject:iconChecking forKey:@"ISI_AlternateMenuBarItem"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}

	[iconChecking release];
}

int donateCheck()
{
	NSNumber *donateChecking = [[NSUserDefaults standardUserDefaults] objectForKey:@"ISI_Donation"];
	if (!donateChecking) {
		donateChecking = [NSNumber numberWithBool:NSRunAlertPanel(NSLocalizedString(@"Would you like to donate?", nil), [NSString stringWithFormat:NSLocalizedString(@"A lot of effort goes into writing and testing iSyncIt. If you like the results please consider making a donation via the button on the right of the website.", nil)], NSLocalizedString(@"Donate", nil), NSLocalizedString(@"Not Now", nil), nil) == NSAlertDefaultReturn];
		[[NSUserDefaults standardUserDefaults] setObject:donateChecking forKey:@"ISI_Donation"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ISI_Donation"]) {
			[[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"http://digitalpardoe.co.uk/"]];
		}
	}
}

int lastSyncCheck()
{
	NSNumber *lastSyncChecking = [[NSUserDefaults standardUserDefaults] objectForKey:@"ISI_LastSync"];
	if (!lastSyncChecking) {
		[[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"ISI_LastSync"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}

@end
