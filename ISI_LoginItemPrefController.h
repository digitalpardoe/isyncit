//
//  ISI_LoginItemPrefController.h
//  iSyncIt
//
//  Created by Alex on 31/05/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SS_PreferencePaneProtocol.h"
#import "DPLoginItem.h"

@interface ISI_LoginItemPrefController : NSObject <SS_PreferencePaneProtocol>
{
	IBOutlet NSView *prefsView;
	IBOutlet NSButton *loginButton;
}

- (IBAction)pref_Act_AddToLogin:(id)sender;

@end
