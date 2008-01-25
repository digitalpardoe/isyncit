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
#import <Growl/Growl.h>
#import "ISI_Bluetooth.h"
#import "ISI_WindowController.h"
#import "ISI_Sync.h"
#import "ISI_StartupChecks.h"
#import "ISI_Scheduling.h"

@interface ISI_MenusController : NSObject <GrowlApplicationBridgeDelegate>
{
    IBOutlet NSMenuItem *menuBT_Out_SendFile;
    IBOutlet NSMenuItem *menuBT_Out_SetUpDev;
    IBOutlet NSMenuItem *menuBT_Out_TurnOn;
    IBOutlet NSMenu *menuMM_Out;
    IBOutlet NSMenuItem *menuMM_Out_Bluetooth;
    IBOutlet NSMenuItem *menuMM_Out_LastSync;
	IBOutlet NSMenuItem *menuMM_Out_CheckUpdates;
	
	NSStatusItem *menuBarItem;
	
	NSUserDefaults *defaults;
	BOOL enableBluetooth;
	BOOL menuBarIcon;
	
	BOOL growlReady;
	
	ISI_Scheduling *schedulingControl;
	ISI_Sync *syncControl;
}

- (void)initialiseMenu;

- (void)changeMenu;

- (void)readMenuDefaults;

- (void)initializeGrowl;

- (void)showGrowlNotification : (NSString *)growlName : (NSString *)growlTitle : (NSString *)gowlDescription;

- (IBAction)menuBM_Act_SendFile:(id)sender;

- (IBAction)menuBM_Act_SetUpDev:(id)sender;

- (IBAction)menuBM_Act_TurnOn:(id)sender;

- (IBAction)menuMM_Act_ChangeLog:(id)sender;

- (IBAction)menuMM_Act_Preferences:(id)sender;

- (IBAction)menuMM_Act_SyncNow:(id)sender;

- (IBAction)menuMM_Act_AboutDialog:(id)sender;

- (IBAction)menuMM_Act_Donate:(id)sender;

@end
