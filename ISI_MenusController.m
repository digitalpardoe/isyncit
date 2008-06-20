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
	// Pull to front, mainly for first runs.
	[NSApp activateIgnoringOtherApps:YES];
	
	// First run, start-up checks.
	startupChecks();
	
	// Load the user preferences file into memory.
	defaults = [NSUserDefaults standardUserDefaults];
	
	[self readMenuDefaults];
	
	[self initialiseMenu];

	// Read the bluetooth settings from user defaults.
	enableBluetooth = [defaults boolForKey:@"ISI_EnableBluetooth"];
	
	[[DPGrowl theGrowl] initializeGrowl];
	
	// Start the scheduler.
	schedulingControl = [[ISI_Scheduling alloc] init];
	[schedulingControl goSchedule];
}

- (void)initialiseMenu
{
	// Fill the menu bar item.
    menuBarItem = [[[NSStatusBar systemStatusBar]
            statusItemWithLength:NSSquareStatusItemLength] retain];
	
	// Set up the menu bar item & fill it.
    [menuBarItem setHighlightMode:YES];
	
	[self changeMenu];
	
	// Initialise the menu bar so the user can operate the program.
    [menuBarItem setMenu:theMenu];
    [menuBarItem setEnabled:YES];
}

- (void)readMenuDefaults
{
	// Read the icon settings from user defaults.
	menuBarIcon = [defaults boolForKey:@"ISI_AlternateMenuBarItem"];
}

- (void)changeMenu
{
	if (menuBarIcon == TRUE) {
		if ((BTPowerState() ? "on" : "off") == "off") {
			[menuBarItem setImage:[NSImage imageNamed:@"ISI_MenuIconAlternate"]];
		} else {
			[menuBarItem setImage:[NSImage imageNamed:@"ISI_MenuIconAlternate_On"]]; 
		}
	} else {
		if ((BTPowerState() ? "on" : "off") == "off") {
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
	// Opens the bluetooth file exchange.
	NSString *sendFilesString = @"tell application \"Bluetooth File Exchange\"\r activate\r end tell";
	NSAppleScript *sendFilesScript = [[NSAppleScript alloc] initWithSource:sendFilesString];
	[sendFilesScript executeAndReturnError:nil];
}

- (IBAction)doSetUpDevice:(id)sender
{
	// Open the bluetooth setup assistant.
	NSString *setDeviceString = @"tell application \"Bluetooth Setup Assistant\"\r activate\r end tell";
	NSAppleScript *setDeviceScript = [[NSAppleScript alloc] initWithSource:setDeviceString];
	[setDeviceScript executeAndReturnError:nil];
}

- (IBAction)turnBluetoothOn:(id)sender
{
	// Sets the power state to on or off depending on which one is already set.
	if (IOBluetoothPreferencesAvailable()) {
		if ((BTPowerState() ? "on" : "off") == "on") {
			BTSetPowerState(0);
			[[DPGrowl theGrowl] showGrowlNotification : @"BluetoothOff" : @"Bluetooth Off" : @"Your bluetooth hardware has been turned off."];
		} else {
			BTSetPowerState(1);
			[[DPGrowl theGrowl] showGrowlNotification : @"BluetoothOn" : @"Bluetooth On" : @"Your bluetooth hardware has been turned on."];
		}
	}
			
	[self changeMenu];
}

- (IBAction)showChangeLog:(id)sender
{
	// Makes sure the app is frontmost and displays the Change Log.
	[NSApp activateIgnoringOtherApps:YES];
	ISI_WindowController *changeLogWindow = [[ISI_WindowController alloc] initWithWindowNibName:@"ISI_ChangeLog"];
	[changeLogWindow showWindow:self];
}

- (IBAction)showPreferences:(id)sender
{
	// Makes sure the app is frontmost and displays the Preferences.
	[NSApp activateIgnoringOtherApps:YES];
	
	if (!prefs)
	{
		// Determine path to the sample preference panes
		NSString *pathToPanes = [NSString stringWithFormat:@"%@/../Preference Panes", [[NSBundle mainBundle] resourcePath]];
		
		prefs = [[SS_PrefsController alloc] initWithPanesSearchPath:pathToPanes];
		
		[prefs setAlwaysShowsToolbar:YES];
		[prefs setDebug:NO];
		
		[prefs setAlwaysOpensCentered:YES];
		
		[prefs setPanesOrder:[NSArray arrayWithObjects:@"Bluetooth", @"Scheduling", @"Menu Icon", @"Login Item", @"Updates", nil]];
	}
    
	// Show the preferences window.
	[prefs showPreferencesWindow];
}

- (IBAction)doSync:(id)sender
{
	[ISI_Sync startSync : enableBluetooth];
}

- (IBAction)showAboutDialog:(id)sender
{
	// Makes sure the app is frontmost and displays the About dialog.
	[NSApp activateIgnoringOtherApps:YES];
	[NSApp orderFrontStandardAboutPanel:(id)sender];
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem
{    
	// Deactivates the bluetooth menu if bluetooth is not available.
	if (!IOBluetoothPreferencesAvailable()) {
		if (menuItem == bluetoothMenu) {
			return NO;
		}
	}
	
	// Runs is bluetooth is available.
	if (IOBluetoothPreferencesAvailable()) {
		
		// Activates the necessary menu items that will always remain active with bluetooth.
		if (menuItem == bluetoothMenu) {
			return YES;
		}
		if (menuItem == turnOnBluetooth) {
			return YES;
		}
		
		// Enables the menu items and sets the bluetooth control menu item title if the bluetooth is turned on.
		if ((BTPowerState() ? "on" : "off") == "on") {
			[turnOnBluetooth setTitle:[NSString stringWithFormat:@"Turn Off"]];
			if (menuItem == sendFile) {
				return YES;
			}
			if (menuItem == setUpDevice) {
				return YES;
			}
		}
		
		// Disables the menu items and sets the bluetooth control menu item title if the bluetooth is turned off.
		if ((BTPowerState() ? "on" : "off") == "off") {
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
	// Forces the user into donation.
	[[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=contact%40digitalpardoe%2eco%2euk&item_name=digital%3apardoe&no_shipping=1&no_note=1&tax=0&currency_code=GBP&lc=GB&bn=PP%2dDonationsBF&charset=UTF%2d8"]];
}

@end
