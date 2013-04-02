/*
 * ISI_StatusMenu.m
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import "ISI_StatusMenu.h"

@implementation ISI_StatusMenu

// Implementated when the main interface is loaded.
- (void)awakeFromNib
{

	// Initialising the status bar item.
    statusItem = [[[NSStatusBar systemStatusBar]
            statusItemWithLength:NSSquareStatusItemLength] retain];

    [statusItem setHighlightMode:YES];
	
	// Set the status bar item icon or text.
	[statusItem setImage:[NSImage imageNamed:@"ISI_MenuIcon"]];
	 
	/* 
	 * To set the status bar item as text use:
	 *		[statusItem setTitle:[NSString stringWithFormat:@"%C",0x27B2]];
	 * instead of setImage.
	 *
	 */
	
	// Set up the status bar item properties.
    [statusItem setMenu:theMenu];
    [statusItem setEnabled:YES];
}

// Perform operation to free resource allocations.
-(void)dealloc
{
	
	// Release the satus bar item.
    [statusItem release];
	
	// Release all other application components.
    [super dealloc];
}

@end
