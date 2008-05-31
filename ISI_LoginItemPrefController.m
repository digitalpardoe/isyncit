//
//  ISI_LoginItemPrefController.m
//  iSyncIt
//
//  Created by Alex on 31/05/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "ISI_LoginItemPrefController.h"

@implementation ISI_LoginItemPrefController

- (IBAction)pref_Act_AddToLogin:(id)sender
{
	// Writes the AppleScript to add iSyncIt to "Login Items".
	NSString *addToLoginString = @"tell application \"System Events\"\r if (count of (login items whose name is equal to \"iSyncIt\")) is not 0 then\r display dialog \"iSyncIt has already been added your login items.\"\r end if\r set the_file to (file of application processes whose name is equal to \"iSyncIt\")\r if (count of the_file) is 0 then\r display dialog \"An error has occured and iSyncIt cannot be found. You will need to add iSyncIt to your login items manually.\"\r end if\r end tell\r set the_path to POSIX path of first item of the_file\r tell application \"System Events\"\r make new login item at the end of login items with properties {path:the_path}\r end tell";
	NSAppleScript *addToLogin = [[NSAppleScript alloc] initWithSource:addToLoginString];
	[addToLogin executeAndReturnError:nil];
}

+ (NSArray *)preferencePanes
{
    return [NSArray arrayWithObjects:[[[ISI_LoginItemPrefController alloc] init] autorelease], nil];
}

- (NSView *)paneView
{
    BOOL loaded = YES;
    
    if (!prefsView) {
        loaded = [NSBundle loadNibNamed:@"ISI_LoginItemView" owner:self];
    }
    
    if (loaded) {
        return prefsView;
    }
    
    return nil;
}

- (NSString *)paneName
{
    return @"Login Item";
}

- (NSImage *)paneIcon
{
    return [[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForImageResource:@"ISI_LoginItem"]] autorelease];
}

- (NSString *)paneToolTip
{
    return @"Login Item Preferences";
}

- (BOOL)allowsHorizontalResizing
{
    return NO;
}

- (BOOL)allowsVerticalResizing
{
    return NO;
}

@end
