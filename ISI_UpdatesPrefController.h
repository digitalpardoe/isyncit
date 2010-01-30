//
//  ISI_UpdatesPrefController.h
//  iSyncIt
//

#import <Cocoa/Cocoa.h>
#import "SS_PreferencePaneProtocol.h"

@interface ISI_UpdatesPrefController : NSObject <SS_PreferencePaneProtocol>
{
	IBOutlet NSView *prefsView;
}

@end
