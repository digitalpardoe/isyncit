/*
 * ISI_Preferences.m
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import "ISI_Preferences.h"

@implementation ISI_Preferences

// Deletes the old version files that no one likes.
- (IBAction)deleteOldVersion:(id)sender
{
	
	// Put the AppleScript in a string, no one likes visible AppleScript.
	NSString *deleteFilesString = @"display dialog \"Are you sure that you want the control files to be removed from your system. (Requires administrator privileges).\" buttons {\"Remove\", \"Leave\"}\r set buttonreturn to button returned of the result\r if buttonreturn = \"Remove\" then\r try\r do shell script \"rm /usr/local/bin/blueutil\" with administrator privileges\r on error\r end try\r try\r do shell script \"rm /usr/local/bin/BluetoothControl\" with administrator privileges\r on error\r end try\r end if";
	
	// Change that string into a nice AppleScript Variable.
	NSAppleScript *deleteFiles = [[NSAppleScript alloc] initWithSource:deleteFilesString];
	
	// Excecute the AppleScript.
	[deleteFiles executeAndReturnError:nil];
	
}

- (void) dealloc
{
	
	// Release all other application components.
	[super dealloc];
	
}

@end