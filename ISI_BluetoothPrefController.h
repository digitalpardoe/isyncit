//
//  ISI_BluetoothPrefController.h
//  iSyncIt
//
//	See 'LICENSE' for copyright and licensing.
//

#import <Cocoa/Cocoa.h>
#import "SS_PreferencePaneProtocol.h"

@interface ISI_BluetoothPrefController : NSObject <SS_PreferencePaneProtocol>
{
	IBOutlet NSButton *pref_Out_BTControlOption;
	
	IBOutlet NSView *prefsView;
}

- (IBAction)pref_Act_SwitchBluetooth:(id)sender;

@end
