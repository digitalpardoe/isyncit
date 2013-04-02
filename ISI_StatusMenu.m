/*
 * ISI_StatusMenu.m
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import "ISI_StatusMenu.h"
#import "ISI_Bluetooth.h"

@implementation ISI_StatusMenu

- (void)awakeFromNib
{
	// Set up the status and initialize the status menu item.
    statusItem = [[[NSStatusBar systemStatusBar]
            statusItemWithLength:NSSquareStatusItemLength] retain];
    [statusItem setHighlightMode:YES];
	[statusItem setImage:[NSImage imageNamed:@"ISI_MenuIcon"]];
	 
	/* 
	 * To set the status bar item as text use:
	 *		[statusItem setTitle:[NSString stringWithFormat:@"%C",0x27B2]];
	 * instead of setImage.
	 *
	 */
	
    [statusItem setMenu:theMenu];
    [statusItem setEnabled:YES];
	
	// Change the title of the menu item on load.
	[syncMenuItem setTitle:[NSString stringWithFormat:@"Sync Now..."]];
}

- (IBAction)bluetoothControl:(id)sender
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

- (IBAction)bluetoothSetDevice:(id)sender
{
	// Open the bluetooth setup assistant.
	NSString *setDeviceString = @"tell application \"Bluetooth Setup Assistant\"\r activate\r end tell";
	NSAppleScript *setDeviceScript = [[NSAppleScript alloc] initWithSource:setDeviceString];
	[setDeviceScript executeAndReturnError:nil];
}

- (IBAction)bluetoothSendFiles:(id)sender
{
	// Opens the bluetooth file exchange.
	NSString *sendFilesString = @"tell application \"Bluetooth File Exchange\"\r activate\r end tell";
	NSAppleScript *sendFilesScript = [[NSAppleScript alloc] initWithSource:sendFilesString];
	[sendFilesScript executeAndReturnError:nil];
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem
{
	// Deactivates the bluetooth menu if bluetooth is not available.
	if (!IOBluetoothPreferencesAvailable()) {
		if (menuItem == bluetoothSubMenu) {
			return NO;
		}
	}
	
	// Runs is bluetooth is available.
	if (IOBluetoothPreferencesAvailable()) {
		
		// Activates the necessary menu items that will always remain active with bluetooth.
		if (menuItem == bluetoothSubMenu) {
			return YES;
		}
		if (menuItem == bluetoothMenuItem) {
			return YES;
		}
		
		// Enables the menu items and sets the bluetooth control menu item title if the bluetooth is turned on.
		if ((BTPowerState() ? "on" : "off") == "on") {
			[bluetoothMenuItem setTitle:[NSString stringWithFormat:@"Turn Off"]];
			if (menuItem == bluetoothSendFile) {
				return YES;
			}
			if (menuItem == bluetoothSetDev) {
				return YES;
			}
		}
		
		// Disables the menu items and sets the bluetooth control menu item title if the bluetooth is turned off.
		if ((BTPowerState() ? "on" : "off") == "off") {
			[bluetoothMenuItem setTitle:[NSString stringWithFormat:@"Turn On"]];
			if (menuItem == bluetoothSendFile) {
				return NO;
			}
			if (menuItem == bluetoothSetDev) {
				return NO;
			}
		}
	}
}

- (void)dealloc
{
	[theMenu release];
	[syncMenuItem release];
	[bluetoothMenuItem release];
	[bluetoothSubMenu release];
	[bluetoothSetDev release];
	[bluetoothSendFile release];
    [statusItem release];
    [super dealloc];
}

@end
