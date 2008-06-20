//
//  ISI_BluetoothPrefController.m
//  iSyncIt
//
//  Created by Alex on 31/05/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "ISI_BluetoothPrefController.h"

@implementation ISI_BluetoothPrefController

- (IBAction)pref_Act_SwitchBluetooth:(id)sender
{
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)awakeFromNib
{
	// Disables bluetooth preference if it is not available.
	if (!IOBluetoothPreferencesAvailable()) {
		[pref_Out_BTControlOption setEnabled:NO];
	}
}

+ (NSArray *)preferencePanes
{
    return [NSArray arrayWithObjects:[[[ISI_BluetoothPrefController alloc] init] autorelease], nil];
}

- (NSView *)paneView
{
    BOOL loaded = YES;
    
    if (!prefsView) {
        loaded = [NSBundle loadNibNamed:@"ISI_BluetoothView" owner:self];
    }
    
    if (loaded) {
        return prefsView;
    }
    
    return nil;
}

- (NSString *)paneName
{
    return @"Bluetooth";
}

- (NSImage *)paneIcon
{
    return [[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForImageResource:@"ISI_Bluetooth"]] autorelease];
}

- (NSString *)paneToolTip
{
    return @"Bluetooth Preferences";
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
