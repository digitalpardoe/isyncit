/*
 * ISI_SyncController.h
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import <Cocoa/Cocoa.h>

@interface ISI_SyncController : NSObject
{

	// Script to control the syncing with iSync.
	NSAppleScript *script;
	
}

- (IBAction)performSync:(id)sender;
@end

