//
//  ISI_MenusController.h
//  iSyncIt
//

#import <Cocoa/Cocoa.h>
#import "ISI_WindowController.h"
#import "ISI_StartupChecks.h"
#import "ISI_Scheduling.h"
#import "SS_PrefsController.h"

@interface ISI_MenusController : NSObject
{
    IBOutlet NSMenuItem *sendFile;
    IBOutlet NSMenuItem *setUpDevice;
    IBOutlet NSMenuItem *turnOnBluetooth;
    IBOutlet NSMenu *theMenu;
    IBOutlet NSMenuItem *bluetoothMenu;
    IBOutlet NSMenuItem *lastSyncTime;
	IBOutlet NSMenuItem *updateCheck;
	
	NSStatusItem *menuBarItem;
	
	NSUserDefaults *defaults;
	BOOL enableBluetooth;
	BOOL menuBarIcon;
	
	ISI_Scheduling *schedulingControl;
	SS_PrefsController *prefs;
	
	NSTimer *bluetoothWatcher;
	ISI_WindowController *changeLogWindow;
}

- (void)updateMenu;

- (IBAction)doSendFile:(id)sender;

- (IBAction)doSetUpDevice:(id)sender;

- (IBAction)turnBluetoothOn:(id)sender;

- (IBAction)showChangeLog:(id)sender;

- (IBAction)showPreferences:(id)sender;

- (IBAction)doSync:(id)sender;

- (IBAction)showAboutDialog:(id)sender;

- (IBAction)makeDonation:(id)sender;

@end
