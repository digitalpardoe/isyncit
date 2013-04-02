/*
 * ISI_Preferences.h
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import <Cocoa/Cocoa.h>

@interface ISI_Preferences : NSObject
{
	 IBOutlet NSButton *bluetoothControl;
}

- (IBAction)deleteOldVersion:(id)sender;

@end
