/*
 * ISI_PrefController.h
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import <Cocoa/Cocoa.h>
#import "ISI_Bluetooth.h"
#import "ISI_Scheduling.h"
#import "NSApplicationAdditions.h"

@interface ISI_PrefController : NSObject
{
    IBOutlet NSButton *pref_Out_BTControlOption;
	IBOutlet NSComboBox *pref_Out_SchedulingCombo;
	
	BOOL enableScheduling;
}

- (IBAction)pref_Act_SwitchBluetooth:(id)sender;

- (IBAction)pref_Act_PerformCleanup:(id)sender;

- (IBAction)pref_Act_AddToLogin:(id)sender;

- (IBAction)pref_Act_ActivateSchedule:(id)sender;

- (IBAction)pref_Act_ChangeSchedule:(id)sender;

- (IBAction)pref_Act_RestartApp:(id)sender;

@end
