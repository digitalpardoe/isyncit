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
#import "ISI_Bluetooth.h"

@implementation ISI_Sync

// Performs bluetooth control and syncing.
- (IBAction)syncNow:(id)sender
{
	
	char *currentStatus[3];
	
	currentStatus[3] = BTPowerState() ? "on" : "off";
	
	/*
	 * Acces bluetooth power state with the following:
	 * BTPowerState() ? "on" : "off"
	 *
	 * Set bluetooth power state: 0 = off, 1 = on
	 *
	 */
	
	if (currentStatus[3] == "off") {
		BTSetPowerState(1);
	}
	
	// Set the name of the menu item.
	[syncMenuItem setTitle:[NSString stringWithFormat:@"Syncing..."]];
	
	// Put the AppleScript in a string, no one likes visible AppleScript.
	NSString *syncNowString = @"tell application \"iSync\"\r if not (synchronize) then\r else\r repeat while (syncing is true)\r delay 5\r end repeat\r quit\r end if\r end tell";
	
	// Change that string into a nice AppleScript Variable.
	NSAppleScript *syncNowScript = [[NSAppleScript alloc] initWithSource:syncNowString];
	
	// Excecute the AppleScript.
	[syncNowScript executeAndReturnError:nil];
	
	
	// Reset the menu item.
	[syncMenuItem setTitle:[NSString stringWithFormat:@"Sync Now..."]];
	
	if (currentStatus[3] == "off") {
		BTSetPowerState(0);
	}
	
	

}

// Perform operation to free resource allocations.
- (void) dealloc
{
	
	// Release the menu item.
	[syncMenuItem release];
	
	// Release all other application components.
	[super dealloc];
	
}

@end
