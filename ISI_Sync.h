/*
 * ISI_Sync.h
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import <Cocoa/Cocoa.h>

@interface ISI_Sync : NSObject
{
	
	// Sync Now... menu item.
    IBOutlet NSMenuItem *syncMenuItem;
	
}

// Action to link to menu item.
- (IBAction)syncNow:(id)sender;
@end
