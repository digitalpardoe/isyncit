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

// Perform the syncing and the controlling of the bluetooth.
int syncNow()
{
	// Variable declarations.
	NSUserDefaults *defaults;
	BOOL enableBluetooth;
	char *currentStatus[3];
	
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
	
	// Release necessary variables.
	[defaults release];
	
	// Return to main program.
	return EXIT_SUCCESS;
}

@end
