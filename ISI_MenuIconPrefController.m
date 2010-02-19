//
//  ISI_MenuIconPrefController.m
//  iSyncIt
//
//	See 'LICENSE' for copyright and licensing.
//

#import "ISI_MenuIconPrefController.h"

@implementation ISI_MenuIconPrefController

- (IBAction)pref_Act_ChangeMenuIcon:(id)sender
{
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSArray *)preferencePanes
{
    return [NSArray arrayWithObjects:[[[ISI_MenuIconPrefController alloc] init] autorelease], nil];
}

- (NSView *)paneView
{
    BOOL loaded = YES;
    
    if (!prefsView) {
        loaded = [NSBundle loadNibNamed:@"ISI_MenuIconView" owner:self];
    }
    
    if (loaded) {
        return prefsView;
    }
    
    return nil;
}

- (NSString *)paneName
{
    return @"Menu Icon";
}

- (NSImage *)paneIcon
{
    return [[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForImageResource:@"ISI_MenuIconItem"]] autorelease];
}

- (NSString *)paneToolTip
{
    return @"Menu Icon Preferences";
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
	[prefsView release];
	[super dealloc];
}

@end
