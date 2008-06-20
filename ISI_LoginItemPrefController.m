//
//  ISI_LoginItemPrefController.m
//  iSyncIt
//
//  Created by Alex on 31/05/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "ISI_LoginItemPrefController.h"

@implementation ISI_LoginItemPrefController

- (void)awakeFromNib
{
	doLogin = [[DPLoginItem alloc] init];
	
	if ([doLogin inLoginItems])
	{
		[loginButton setState:1];
	} else {
		[loginButton setState:0];
	}
}

- (IBAction)pref_Act_AddToLogin:(id)sender
{
	if (![doLogin inLoginItems])
	{
		[doLogin addToLoginItems];
	} else {
		[doLogin removeFromLoginItems];
	}
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