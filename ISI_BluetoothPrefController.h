//
//  ISI_BluetoothPrefController.h
//  iSyncIt
//
//  Created by Alex on 31/05/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
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
