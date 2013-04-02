/*
 * ISI_MenusController.h
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import <Cocoa/Cocoa.h>
#import "ISI_Bluetooth.h"
#import "ISI_WindowController.h"

@interface ISI_MenusController : NSObject
{
    IBOutlet NSMenuItem *menuBT_Out_SendFile;
    IBOutlet NSMenuItem *menuBT_Out_SetUpDev;
    IBOutlet NSMenuItem *menuBT_Out_TurnOn;
    IBOutlet NSMenu *menuMM_Out;
    IBOutlet NSMenuItem *menuMM_Out_Bluetooth;
    IBOutlet NSMenuItem *menuMM_Out_SyncNow;
	IBOutlet NSMenuItem *menuMM_Out_CheckUpdates;
	
	NSStatusItem *menuBarItem;
	NSUserDefaults *defaults;
	
	BOOL enableBluetooth;
	char *currentStatus[3];
}

- (void)syncNow:(id)sender;

- (IBAction)menuBM_Act_SendFile:(id)sender;

- (IBAction)menuBM_Act_SetUpDev:(id)sender;

- (IBAction)menuBM_Act_TurnOn:(id)sender;

- (IBAction)menuMM_Act_ChangeLog:(id)sender;

- (IBAction)menuMM_Act_Preferences:(id)sender;

- (IBAction)menuMM_Act_SyncNow:(id)sender;

- (IBAction)menuMM_Act_AboutDialog:(id)sender;

@end
