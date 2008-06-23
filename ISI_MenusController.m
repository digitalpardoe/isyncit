/*
 * ISI_MenusController.m
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import "ISI_MenusController.h"

@implementation ISI_MenusController

- (void)awakeFromNib
{
	[NSApp activateIgnoringOtherApps:YES];
	[ISI_StartupChecks startupChecks];
	
	defaults = [NSUserDefaults standardUserDefaults];
	menuBarIcon = [defaults boolForKey:@"ISI_AlternateMenuBarItem"];
	menuBarItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength] retain];
	
    [menuBarItem setHighlightMode:YES];
	[self updateMenu];
	
    [menuBarItem setMenu:theMenu];
    [menuBarItem setEnabled:YES];

	enableBluetooth = [defaults boolForKey:@"ISI_EnableBluetooth"];
	
	[[DPGrowl theGrowl] initializeGrowl];
	
	schedulingControl = [[ISI_Scheduling alloc] init];
	[schedulingControl goSchedule];
	
	[[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMenu) name:@"uk.co.digitalpardoe.iSyncIt.updateMenu" object:nil];
}

- (void)updateMenu
{	
	if (menuBarIcon == TRUE) {
		if ([ISI_Bluetooth getPowerState] == 0) {
			[menuBarItem setImage:[NSImage imageNamed:@"ISI_MenuIconAlternate"]];
		} else {
			[menuBarItem setImage:[NSImage imageNamed:@"ISI_MenuIconAlternate_On"]]; 
		}
	} else {
		if ([ISI_Bluetooth getPowerState] == 0) {
			[menuBarItem setImage:[NSImage imageNamed:@"ISI_MenuIcon"]];
		} else {
			[menuBarItem setImage:[NSImage imageNamed:@"ISI_MenuIcon_On"]];
		}
	}
	
	NSString *tempString = [@"" stringByAppendingString:[[defaults objectForKey:@"ISI_LastSync"] descriptionWithCalendarFormat:@"%a %d %b, %H:%M" timeZone:[NSTimeZone systemTimeZone] locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]]];
	[lastSyncTime setTitle:[[[@"" stringByAppendingString:@"Last Sync"] stringByAppendingString:@": "] stringByAppendingString:tempString]];
}

- (IBAction)doSendFile:(id)sender
{
	NSString *sendFilesString = @"tell application \"Bluetooth File Exchange\"\r activate\r end tell";
	NSAppleScript *sendFilesScript = [[NSAppleScript alloc] initWithSource:sendFilesString];
	[sendFilesScript executeAndReturnError:nil];
}

- (IBAction)doSetUpDevice:(id)sender
{
	NSString *setDeviceString = @"tell application \"Bluetooth Setup Assistant\"\r activate\r end tell";
	NSAppleScript *setDeviceScript = [[NSAppleScript alloc] initWithSource:setDeviceString];
	[setDeviceScript executeAndReturnError:nil];
}

- (IBAction)turnBluetoothOn:(id)sender
{
	[ISI_Bluetooth togglePowerState];
	[self updateMenu];
}

- (IBAction)showChangeLog:(id)sender
{
	[NSApp activateIgnoringOtherApps:YES];
	ISI_WindowController *changeLogWindow = [[ISI_WindowController alloc] initWithWindowNibName:@"ISI_ChangeLog"];
	[changeLogWindow showWindow:self];
}

- (IBAction)showPreferences:(id)sender
{
	[NSApp activateIgnoringOtherApps:YES];
	
	if (!prefs)
	{
		NSString *pathToPanes = [NSString stringWithFormat:@"%@/../Preference Panes", [[NSBundle mainBundle] resourcePath]];
		
		prefs = [[SS_PrefsController alloc] initWithPanesSearchPath:pathToPanes];
		
		[prefs setAlwaysShowsToolbar:YES];
		[prefs setDebug:NO];
		
		[prefs setAlwaysOpensCentered:YES];
		
		[prefs setPanesOrder:[NSArray arrayWithObjects:@"Bluetooth", @"Scheduling", @"Menu Icon", @"Login Item", @"Updates", nil]];
	}
    
	[prefs showPreferencesWindow];
}

- (IBAction)doSync:(id)sender
{
	[ISI_Sync startSync : enableBluetooth];
}

- (IBAction)showAboutDialog:(id)sender
{
	[NSApp activateIgnoringOtherApps:YES];
	[NSApp orderFrontStandardAboutPanel:(id)sender];
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem
{    
	if (![ISI_Bluetooth available]) {
		if (menuItem == bluetoothMenu) {
			return NO;
		}
	}
	
	if ([ISI_Bluetooth available]) {
		if (menuItem == bluetoothMenu) {
			return YES;
		}
		
		if (menuItem == turnOnBluetooth) {
			return YES;
		}
		
		if ([ISI_Bluetooth getPowerState] == 1) {
			[turnOnBluetooth setTitle:[NSString stringWithFormat:@"Turn Off"]];
			if (menuItem == sendFile) {
				return YES;
			}
			if (menuItem == setUpDevice) {
				return YES;
			}
		}
		
		if ([ISI_Bluetooth getPowerState] == 0) {
			[turnOnBluetooth setTitle:[NSString stringWithFormat:@"Turn On"]];
			if (menuItem == sendFile) {
				return NO;
			}
			
			if (menuItem == setUpDevice) {
				return NO;
			}
		}
	}
}

- (IBAction)makeDonation:(id)sender
{
	[[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=contact%40digitalpardoe%2eco%2euk&item_name=digital%3apardoe&no_shipping=1&no_note=1&tax=0&currency_code=GBP&lc=GB&bn=PP%2dDonationsBF&charset=UTF%2d8"]];
}

- (void)dealloc
{
	[sendFile release];
    [setUpDevice release];
    [turnOnBluetooth release];
	[theMenu release];
    [bluetoothMenu release];
    [lastSyncTime release];
	[updateCheck release];
	[menuBarItem release];
	[defaults release];
	[schedulingControl release];
	[prefs release];
	[super dealloc];
}

@end
