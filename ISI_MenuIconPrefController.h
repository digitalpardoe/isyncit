//
//  ISI_MenuIconPrefController.h
//  iSyncIt
//

#import <Cocoa/Cocoa.h>
#import "SS_PreferencePaneProtocol.h"

@interface ISI_MenuIconPrefController : NSObject <SS_PreferencePaneProtocol>
{
	IBOutlet NSView *prefsView;
}

- (IBAction)pref_Act_ChangeMenuIcon:(id)sender;

@end
