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
    menuBarItem = [[[NSStatusBar systemStatusBar]
            statusItemWithLength:NSSquareStatusItemLength] retain];
	
    [menuBarItem setHighlightMode:YES];
	[menuBarItem setImage:[NSImage imageNamed:@"ISI_MenuIcon"]];
	
	/* 
	 * To set the status bar item as text use:
	 *		[statusItem setTitle:[NSString stringWithFormat:@"%C",0x27B2]];
	 * instead of setImage.
	 *
	 */
	
    [menuBarItem setMenu:menuMM_Out];
    [menuBarItem setEnabled:YES];
}

- (void)syncNow:(id)sender
{
	// Read the bluetooth settings from user defaults.
	defaults = [NSUserDefaults standardUserDefaults];
	enableBluetooth = [defaults boolForKey:@"ISI_EnableBluetooth"];
	
	// Assuming bluetooth is available and the user wishes it turn the power on (if needed).
	if (IOBluetoothPreferencesAvailable()) {
		if (enableBluetooth == TRUE) {
			currentStatus[3] = BTPowerState() ? "on" : "off";
			if (currentStatus[3] == "off") {
				BTSetPowerState(1);
			}
		}
	}
	
	// Perform the sync by writing in an AppleScript and excecuting.
	NSString *syncNowString = @"tell application \"iSync\"\r if not (synchronize) then\r else\r repeat while (syncing is true)\r delay 5\r end repeat\r quit\r end if\r end tell";
	NSAppleScript *syncNowScript = [[NSAppleScript alloc] initWithSource:syncNowString];
	[syncNowScript executeAndReturnError:nil];
	
	// Assuming bluetooth is available reset it's state to the original.
	if (IOBluetoothPreferencesAvailable()) {
		if (enableBluetooth == TRUE) {
			if (currentStatus[3] == "off") {
				BTSetPowerState(0);
			}
		}
	}
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
}

- (IBAction)menuMM_Act_ChangeLog:(id)sender
{
	[NSApp activateIgnoringOtherApps:YES];
	ISI_WindowController *changeLogWindow = [[ISI_WindowController alloc] initWithWindowNibName:@"ISI_ChangeLog"];
	[changeLogWindow showWindow:self];
}

- (IBAction)menuMM_Act_Preferences:(id)sender
{
	[NSApp activateIgnoringOtherApps:YES];
	ISI_WindowController *prefWindow = [[ISI_WindowController alloc] initWithWindowNibName:@"ISI_Preferences"];
	[prefWindow showWindow:self];
}

- (IBAction)menuMM_Act_SyncNow:(id)sender
{
	[self syncNow:(id)sender];
}

- (IBAction)menuMM_Act_AboutDialog:(id)sender
{
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
			[menuBT_Out_TurnOn setTitle:[NSString stringWithFormat:@"Turn Off"]];
			if (menuItem == menuBT_Out_SendFile) {
				return YES;
			}
			if (menuItem == menuBT_Out_SetUpDev) {
				return YES;
			}
		}
		
		// Disables the menu items and sets the bluetooth control menu item title if the bluetooth is turned off.
		if ((BTPowerState() ? "on" : "off") == "off") {
			[menuBT_Out_TurnOn setTitle:[NSString stringWithFormat:@"Turn On"]];
			if (menuItem == menuBT_Out_SendFile) {
				return NO;
			}
			if (menuItem == menuBT_Out_SetUpDev) {
				return NO;
			}
		}
	}

}

- (void) dealloc {
	[menuBT_Out_SendFile release];
    [menuBT_Out_SetUpDev release];
    [menuBT_Out_TurnOn release];
    [menuMM_Out release];
    [menuMM_Out_Bluetooth release];
    [menuMM_Out_SyncNow release];
	[defaults release];
	[super dealloc];
}

@end
