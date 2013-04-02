/*
 * ISI_StatusMenu.h
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import <Cocoa/Cocoa.h>

@interface ISI_StatusMenu : NSObject
{

	// The status item that will be added to the System Status bar.
    NSStatusItem *statusItem;

    // The menu to be attatched to the status item.
    IBOutlet NSMenu *theMenu;

}

@end
