//
//  ISI_StartupChecks.m
//  iSyncIt
//

#import "ISI_StartupChecks.h"

@implementation ISI_StartupChecks

+ (void)startupChecks
{
	[self _lastSyncCheck];
	[self _bluetoothCheck];
	[self _updateCheck];
	[self _donateCheck];
}

+ (void)_bluetoothCheck
{
	NSNumber *bluetoothSyncing = [[NSUserDefaults standardUserDefaults] objectForKey:@"ISI_EnableBluetooth"];
	if (!bluetoothSyncing) {
		bluetoothSyncing = [NSNumber numberWithBool:NSRunAlertPanel(@"Enable automatic bluetooth control?", [NSString stringWithFormat:@"Would you like bluetooth to be automatically controlled by iSyncIt during syncing?"], @"Enable", @"Don't Enable", nil) == NSAlertDefaultReturn];
		[[NSUserDefaults standardUserDefaults] setObject:bluetoothSyncing forKey:@"ISI_EnableBluetooth"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}

+ (void)_updateCheck
{
	NSNumber *updateChecking = [[NSUserDefaults standardUserDefaults] objectForKey:@"SUCheckAtStartup"];
	if (!updateChecking) {
		updateChecking = [NSNumber numberWithBool:NSRunAlertPanel(@"Check for updates on startup?", [NSString stringWithFormat:@"Would you like iSyncIt to check for updates on startup? If not, you can initiate the check manually from the application menu"], @"Yes", @"No", nil) == NSAlertDefaultReturn];
		[[NSUserDefaults standardUserDefaults] setObject:updateChecking forKey:@"SUCheckAtStartup"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}

+ (void) _donateCheck
{
	NSNumber *donateChecking = [[NSUserDefaults standardUserDefaults] objectForKey:@"ISI_Donation"];
	if (!donateChecking) {
		donateChecking = [NSNumber numberWithBool:NSRunAlertPanel(@"Would you like to donate?", [NSString stringWithFormat:@"A lot of effort goes into writing and testing iSyncIt. If you like the results please consider making a donation."], @"Donate", @"Not Now", nil) == NSAlertDefaultReturn];
		[[NSUserDefaults standardUserDefaults] setObject:donateChecking forKey:@"ISI_Donation"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ISI_Donation"]) {
			[[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=contact%40digitalpardoe%2eco%2euk&item_name=digital%3apardoe&no_shipping=1&no_note=1&tax=0&currency_code=GBP&lc=GB&bn=PP%2dDonationsBF&charset=UTF%2d8"]];
		}
	}
}

+ (void)_lastSyncCheck
{
	NSNumber *lastSyncChecking = [[NSUserDefaults standardUserDefaults] objectForKey:@"ISI_LastSync"];
	if (!lastSyncChecking) {
		[[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"ISI_LastSync"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}

@end
