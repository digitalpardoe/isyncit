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
    IBOutlet NSMenuItem *syncMenuItem;
	
	NSUserDefaults *defaults;
	
	BOOL enableBluetooth;
	char *currentStatus[3];
}

- (IBAction)syncNow:(id)sender;

@end
