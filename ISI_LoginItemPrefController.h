//
//  ISI_LoginItemPrefController.h
//  iSyncIt
//
//	See 'LICENSE' for copyright and licensing.
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
