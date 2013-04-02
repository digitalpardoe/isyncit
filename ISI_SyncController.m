/*
 * ISI_SyncController.m
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */
 
#import "ISI_SyncController.h"

@implementation ISI_SyncController

// Connects to the AppleScript.
-(id)init
{
    NSURL *url=[NSURL fileURLWithPath:
            [[[NSBundle mainBundle] resourcePath]
            stringByAppendingPathComponent:@"Scripts/syncscript.scpt"] ];
            
    if(self=[super init])
         script=[[NSAppleScript alloc] initWithContentsOfURL:url error:nil];
         
    return self;
}

// Performs sync on menu item click.
- (IBAction)performSync:(id)sender
{

	// Excecutes the AppleScript.
	[script executeAndReturnError:nil];
	
}

// Remove the resouces when the application has been closed.
- (void) dealloc
{
		
	// Release the AppleScript.
	[script release];
	
	// Release all other application components.
	[super dealloc];
	
}

@end
