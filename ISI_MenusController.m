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
	// First run, start-up checks.
	startupChecks();
	
	// Load the user preferences file into memory.
	defaults = [NSUserDefaults standardUserDefaults];
	
	[self readMenuDefaults];
	
	[self initialiseMenu];

	// Read the bluetooth settings from user defaults.
	enableBluetooth = [defaults boolForKey:@"ISI_EnableBluetooth"];
	
	// Pull to front, mainly for first runs.
	[NSApp activateIgnoringOtherApps:YES];
	
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
	
	/* 
	 * To set the status bar item as text use:
	 *		[statusItem setTitle:[NSString stringWithFormat:@"%C",0x27B2]];
	 * instead of setImage.
	 *
	 */
	
	// Initialise the menu bar so the user can operate the program.
    [menuBarItem setMenu:menuMM_Out];
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
	
	NSString *tempString = [@"" stringByAppendingString:[[defaults objectForKey:@"ISI_LastSync"] descriptionWithCalendarFormat:@"%a %d %b, %H:%M" timeZone:nil locale:nil]];
	[menuMM_Out_LastSync setTitle:[[[@"" stringByAppendingString:NSLocalizedString(@"Last Sync", nil)] stringByAppendingString:@": "] stringByAppendingString:tempString]];
}

- (IBAction)menuBM_Act_SendFile:(id)sender
{
	// Opens the bluetooth file exchange.
	NSString *sendFilesString = @"tell application \"Bluetooth File Exchange\"\r activate\r end tell";
	NSAppleScript *sendFilesScript = [[NSAppleScript alloc] initWithSource:sendFilesString];
	[sendFilesScript executeAndReturnError:nil];
}

- (IBAction)menuBM_Act_SetUpDev:(id)sender
{
	// Open the bluetooth setup assistant.
	NSString *setDeviceString = @"tell application \"Bluetooth Setup Assistant\"\r activate\r end tell";
	NSAppleScript *setDeviceScript = [[NSAppleScript alloc] initWithSource:setDeviceString];
	[setDeviceScript executeAndReturnError:nil];
}

- (IBAction)menuBM_Act_TurnOn:(id)sender
{
	// Sets the power state to on or off depending on which one is already set.
	if (IOBluetoothPreferencesAvailable()) {
		if ((BTPowerState() ? "on" : "off") == "on") {
			BTSetPowerState(0);
		} else {
			BTSetPowerState(1);
		}
	}
	
	[self changeMenu];
}

- (IBAction)menuMM_Act_ChangeLog:(id)sender
{
	// Makes sure the app is frontmost and displays the Change Log.
	[NSApp activateIgnoringOtherApps:YES];
	ISI_WindowController *changeLogWindow = [[ISI_WindowController alloc] initWithWindowNibName:@"ISI_ChangeLog"];
	[changeLogWindow showWindow:self];
}

- (IBAction)menuMM_Act_Preferences:(id)sender
{
	// Makes sure the app is frontmost and displays the Preferences.
	[NSApp activateIgnoringOtherApps:YES];
	ISI_WindowController *prefWindow = [[ISI_WindowController alloc] initWithWindowNibName:@"ISI_Preferences"];
	[prefWindow showWindow:self];
}

- (IBAction)menuMM_Act_SyncNow:(id)sender
{
	syncNow(enableBluetooth);
	[self readMenuDefaults];
	[self changeMenu];
}

- (IBAction)menuMM_Act_AboutDialog:(id)sender
{
	// Makes sure the app is frontmost and displays the About dialog.
	[NSApp activateIgnoringOtherApps:YES];
	[NSApp orderFrontStandardAboutPanel:(id)sender];
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem
{    
	// Deactivates the bluetooth menu if bluetooth is not available.
	if (!IOBluetoothPreferencesAvailable()) {
		if (menuItem == menuMM_Out_Bluetooth) {
			return NO;
		}
	}
	
	// Runs is bluetooth is available.
	if (IOBluetoothPreferencesAvailable()) {
		
		// Activates the necessary menu items that will always remain active with bluetooth.
		if (menuItem == menuMM_Out_Bluetooth) {
			return YES;
		}
		if (menuItem == menuBT_Out_TurnOn) {
			return YES;
		}
		
		// Enables the menu items and sets the bluetooth control menu item title if the bluetooth is turned on.
		if ((BTPowerState() ? "on" : "off") == "on") {
			[menuBT_Out_TurnOn setTitle:[NSString stringWithFormat:NSLocalizedString(@"Turn Off", nil)]];
			if (menuItem == menuBT_Out_SendFile) {
				return YES;
			}
			if (menuItem == menuBT_Out_SetUpDev) {
				return YES;
			}
		}
		
		// Disables the menu items and sets the bluetooth control menu item title if the bluetooth is turned off.
		if ((BTPowerState() ? "on" : "off") == "off") {
			[menuBT_Out_TurnOn setTitle:[NSString stringWithFormat:NSLocalizedString(@"Turn On", nil)]];
			if (menuItem == menuBT_Out_SendFile) {
				return NO;
			}
			if (menuItem == menuBT_Out_SetUpDev) {
				return NO;
			}
		}
	}
}

- (IBAction)menuMM_Act_Donate:(id)sender
{
	// Forces the user into donation.
	NSNumber *donateChecking = [[NSUserDefaults standardUserDefaults] objectForKey:@"ISI_Donation"];
	[NSApp activateIgnoringOtherApps:YES];
	donateChecking = [NSNumber numberWithBool:NSRunAlertPanel(@"Making a donation.", [NSString stringWithFormat:NSLocalizedString(@"Please make a donation by clicking the button on the right hand side of the website.", nil)], NSLocalizedString(@"Donate", nil), nil, nil) == NSAlertDefaultReturn];
	if (donateChecking) {
		[[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"http://digitalpardoe.co.uk/"]];
	}
}


- (void)dealloc
{
	// De-allocate the necessary resources.
	[menuBT_Out_SendFile release];
    [menuBT_Out_SetUpDev release];
    [menuBT_Out_TurnOn release];
    [menuMM_Out release];
    [menuMM_Out_Bluetooth release];
    [menuMM_Out_LastSync release];
	[menuMM_Out release];
	[menuBarItem release];
	[schedulingControl release];
	[defaults release];
	[super dealloc];
}

@end
