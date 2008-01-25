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
#import "NSApplicationAdditions.h"

@interface ISI_PrefController : NSObject
{
    IBOutlet NSButton *pref_Out_BTControlOption;
	IBOutlet NSComboBox *pref_Out_SchedulingCombo;
	IBOutlet NSDatePicker *pref_Out_SchedulingTime;
	
	BOOL enableScheduling;
	BOOL enableTimedScheduling;
}

- (IBAction)pref_Act_ChangeMenuIcon:(id)sender;

- (IBAction)pref_Act_SwitchBluetooth:(id)sender;

- (IBAction)pref_Act_AddToLogin:(id)sender;

- (IBAction)pref_Act_ActivateSchedule:(id)sender;

- (IBAction)pref_Act_ActivateTimedSchedule:(id)sender;

- (IBAction)pref_Act_ChangeSchedule:(id)sender;

- (IBAction)pref_Act_ChangeTimedSchedule:(id)sender;

- (IBAction)pref_Act_RestartApp:(id)sender;

@end
