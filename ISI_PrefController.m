/*
 * ISI_PrefController.m
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import "ISI_PrefController.h"

@implementation ISI_PrefController

- (IBAction)pref_Act_PerformCleanup:(id)sender
{
	// Writes the AppleScript to produce a dialog and perform the delete.
	NSString *deleteFilesString = @"display dialog \"Are you sure that you want the control files to be removed from your system. (Requires administrator privileges).\" buttons {\"Remove\", \"Leave\"}\r set buttonreturn to button returned of the result\r if buttonreturn = \"Remove\" then\r try\r do shell script \"rm /usr/local/bin/blueutil\" with administrator privileges\r on error\r end try\r try\r do shell script \"rm /usr/local/bin/BluetoothControl\" with administrator privileges\r on error\r end try\r end if";
	NSAppleScript *deleteFiles = [[NSAppleScript alloc] initWithSource:deleteFilesString];
	[deleteFiles executeAndReturnError:nil];
}

@end
