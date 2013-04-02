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
    [statusItem setTitle:[NSString stringWithFormat:@"%C",0x27B2]];
	 
	/* 
	 * To set the status bar item as an image create the image and use
	 *		[statusItem setImage:[NSImage imageNamed:@"ISI_Menu"]];
	 * instead of stringWithFormat.
	 *
	*/
	
    [statusItem setMenu:theMenu];
    [statusItem setEnabled:YES];
}

// Remove the resouces when the application has been closed.
-(void)dealloc
{
	
	// Release the satus bar item.
    [statusItem release];
	
	// Release all other application components.
    [super dealloc];
}

@end
