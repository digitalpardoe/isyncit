//
//  ISI_SchedulingPrefController.h
//  iSyncIt
//

#import <Cocoa/Cocoa.h>
#import "SS_PreferencePaneProtocol.h"

@interface ISI_SchedulingPrefController : NSObject <SS_PreferencePaneProtocol>
{
	IBOutlet NSComboBox *pref_Out_SchedulingCombo;
	IBOutlet NSDatePicker *pref_Out_SchedulingTime;
	
	BOOL enableScheduling;
	BOOL enableTimedScheduling;
	
	IBOutlet NSView *prefsView;
}

- (IBAction)pref_Act_ActivateSchedule:(id)sender;

- (IBAction)pref_Act_ActivateTimedSchedule:(id)sender;

- (IBAction)pref_Act_ChangeSchedule:(id)sender;

- (IBAction)pref_Act_ChangeTimedSchedule:(id)sender;

@end
