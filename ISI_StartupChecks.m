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
	lastSyncCheck();
	bluetoothCheck();
	updateCheck();
	donateCheck();
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

int donateCheck()
{
	NSNumber *donateChecking = [[NSUserDefaults standardUserDefaults] objectForKey:@"ISI_Donation"];
	if (!donateChecking) {
		donateChecking = [NSNumber numberWithBool:NSRunAlertPanel(NSLocalizedString(@"Would you like to donate?", nil), [NSString stringWithFormat:NSLocalizedString(@"A lot of effort goes into writing and testing iSyncIt. If you like the results please consider making a donation.", nil)], NSLocalizedString(@"Donate", nil), NSLocalizedString(@"Not Now", nil), nil) == NSAlertDefaultReturn];
		[[NSUserDefaults standardUserDefaults] setObject:donateChecking forKey:@"ISI_Donation"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ISI_Donation"]) {
			[[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=contact%40digitalpardoe%2eco%2euk&item_name=digital%3apardoe&no_shipping=1&no_note=1&tax=0&currency_code=GBP&lc=GB&bn=PP%2dDonationsBF&charset=UTF%2d8"]];
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
