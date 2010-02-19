//
//  ISI_UpdatesPrefController.m
//  iSyncIt
//
//	See 'LICENSE' for copyright and licensing.
//

#import "ISI_UpdatesPrefController.h"

@implementation ISI_UpdatesPrefController

+ (NSArray *)preferencePanes
{
    return [NSArray arrayWithObjects:[[[ISI_UpdatesPrefController alloc] init] autorelease], nil];
}

- (NSView *)paneView
{
    BOOL loaded = YES;
    
    if (!prefsView) {
        loaded = [NSBundle loadNibNamed:@"ISI_UpdatesView" owner:self];
    }
    
    if (loaded) {
        return prefsView;
    }
    
    return nil;
}

- (NSString *)paneName
{
    return @"Updates";
}

- (NSImage *)paneIcon
{
    return [[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForImageResource:@"ISI_Updates"]] autorelease];
}

- (NSString *)paneToolTip
{
    return @"Update Preferences";
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
