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

- (void)awakeFromNib
{
	// Disables bluetooth preference if it is not available.
	if (!IOBluetoothPreferencesAvailable()) {
		[pref_Out_BTControlOption setEnabled:NO];
	}
	
	if (![[NSUserDefaults standardUserDefaults] boolForKey:@"ISI_EnableScheduling"]) {
		[pref_Out_SchedulingCombo setEnabled:NO];
		enableScheduling = NO;
	} else {
		[pref_Out_SchedulingCombo setEnabled:YES];
		enableScheduling = YES;
	}
	
	if (![[NSUserDefaults standardUserDefaults] boolForKey:@"ISI_EnableTimedScheduling"]) {
		[pref_Out_SchedulingTime setEnabled:NO];
		enableTimedScheduling = NO;
	} else {
		[pref_Out_SchedulingTime setEnabled:YES];
		enableTimedScheduling = YES;
	}
}

- (IBAction)pref_Act_SwitchBluetooth:(id)sender
{
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)pref_Act_PerformCleanup:(id)sender
{
	// Writes the AppleScript to produce a dialog and perform the delete.
	NSString *deleteFilesString = @"display dialog \"Are you sure that you want the control files to be removed from your system. (Requires administrator privileges).\" buttons {\"Remove\", \"Leave\"}\r set buttonreturn to button returned of the result\r if buttonreturn = \"Remove\" then\r try\r do shell script \"rm /usr/local/bin/blueutil\" with administrator privileges\r on error\r end try\r try\r do shell script \"rm /usr/local/bin/BluetoothControl\" with administrator privileges\r on error\r end try\r end if";
	NSAppleScript *deleteFiles = [[NSAppleScript alloc] initWithSource:deleteFilesString];
	[deleteFiles executeAndReturnError:nil];
}

- (IBAction)pref_Act_AddToLogin:(id)sender
{
	// Writes the AppleScript to add iSyncIt to "Login Items".
	NSString *addToLoginString = @"tell application \"System Events\"\r if (count of (login items whose name is equal to \"iSyncIt\")) is not 0 then\r display dialog \"iSyncIt has already been added your login items.\"\r end if\r set the_file to (file of application processes whose name is equal to \"iSyncIt\")\r if (count of the_file) is 0 then\r display dialog \"An error has occured and iSyncIt cannot be found. You will need to add iSyncIt to your login items manually.\"\r end if\r end tell\r set the_path to POSIX path of first item of the_file\r tell application \"System Events\"\r make new login item at the end of login items with properties {path:the_path}\r end tell";
	NSAppleScript *addToLogin = [[NSAppleScript alloc] initWithSource:addToLoginString];
	[addToLogin executeAndReturnError:nil];
}

- (IBAction)pref_Act_ActivateSchedule:(id)sender
{
	if (!enableScheduling) {
		[pref_Out_SchedulingCombo setEnabled:YES];
		enableScheduling = YES;
		
		if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ISI_SchedulingSettings"] == nil) {
			[[NSUserDefaults standardUserDefaults] setObject:@"15" forKey:@"ISI_SchedulingSettings"];
		}
		
		[[NSUserDefaults standardUserDefaults] synchronize];
	} else {
		[pref_Out_SchedulingCombo setEnabled:NO];
		enableScheduling = NO;
	}

}

- (IBAction)pref_Act_ActivateTimedSchedule:(id)sender
{
	if (!enableTimedScheduling) {
		[pref_Out_SchedulingTime setEnabled:YES];
		enableTimedScheduling = YES;
		
		if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ISI_TimedSchedulingSettings"] == nil) {
			// Code to set the user default for time if it doesn't exist.
		}
		
		[[NSUserDefaults standardUserDefaults] synchronize];
	} else {
		[pref_Out_SchedulingTime setEnabled:NO];
		enableTimedScheduling = NO;
	}

}

- (IBAction)pref_Act_ChangeSchedule:(id)sender
{
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)pref_Act_ChangeTimedSchedule:(id)sender
{
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)pref_Act_RestartApp:(id)sender
{
	[[NSApplication sharedApplication] relaunch:self];
}

- (void)dealloc
{
	[pref_Out_BTControlOption release];
	[pref_Out_SchedulingCombo release];
	[super dealloc];
}

@end
