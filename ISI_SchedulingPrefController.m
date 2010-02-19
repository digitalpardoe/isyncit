//
//  ISI_SchedulingPrefController.m
//  iSyncIt
//
//	See 'LICENSE' for copyright and licensing.
//

#import "ISI_SchedulingPrefController.h"

@implementation ISI_SchedulingPrefController

- (void)awakeFromNib
{
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

+ (NSArray *)preferencePanes
{
    return [NSArray arrayWithObjects:[[[ISI_SchedulingPrefController alloc] init] autorelease], nil];
}

- (NSView *)paneView
{
    BOOL loaded = YES;
    
    if (!prefsView) {
        loaded = [NSBundle loadNibNamed:@"ISI_SchedulingView" owner:self];
    }
    
    if (loaded) {
        return prefsView;
    }
    
    return nil;
}

- (NSString *)paneName
{
    return @"Scheduling";
}

- (NSImage *)paneIcon
{
    return [[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForImageResource:@"ISI_Scheduling"]] autorelease];
}

- (NSString *)paneToolTip
{
    return @"Scheduling Preferences";
}

- (BOOL)allowsHorizontalResizing
{
    return NO;
}

- (BOOL)allowsVerticalResizing
{
    return NO;
}

- (void)dealloc
{
	[pref_Out_SchedulingCombo release];
	[pref_Out_SchedulingTime release];
	[prefsView release];
	[super dealloc];
}

@end
