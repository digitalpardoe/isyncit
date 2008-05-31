//
//  ISI_UpdatesPrefController.h
//  iSyncIt
//
//  Created by Alex on 31/05/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SS_PreferencePaneProtocol.h"

@interface ISI_UpdatesPrefController : NSObject <SS_PreferencePaneProtocol>
{
	IBOutlet NSView *prefsView;
}

@end
