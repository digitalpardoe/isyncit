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
    NSStatusItem *statusItem;
	
    IBOutlet NSMenu *theMenu;
	IBOutlet NSMenuItem *syncMenuItem;
	IBOutlet NSMenuItem *bluetoothMenuItem;
	IBOutlet NSMenuItem *bluetoothSubMenu;
	IBOutlet NSMenuItem *bluetoothSetDev;
	IBOutlet NSMenuItem *bluetoothSendFile;
}

- (IBAction)bluetoothControl:(id)sender;

- (IBAction)bluetoothSetDevice:(id)sender;

- (IBAction)bluetoothSendFiles:(id)sender;

@end
