//
//  DPGrowl.m
//  iSyncIt
//
//  Created by Alex on 31/05/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "DPGrowl.h"

@implementation DPGrowl

static DPGrowl *singleton;

+ (DPGrowl *)theGrowl
{
	if (!singleton)
		singleton = [[DPGrowl alloc] init];
	
	return singleton;
}

+ (id)alloc
{
	singleton = [super alloc];
	return singleton;
}

- (void)initializeGrowl
{
	[GrowlApplicationBridge setGrowlDelegate:@""];
}

- (void)showGrowlNotification : (NSString *)growlName : (NSString *)growlTitle : (NSString *)growlDescription
{
	// Don't forget to create relevant localizations for the Growl alerts.
	[GrowlApplicationBridge notifyWithTitle:[NSString stringWithFormat:NSLocalizedString(growlTitle, nil)]
								description:[NSString stringWithFormat:NSLocalizedString(growlDescription, nil)]
						   notificationName:growlName
								   iconData:nil
								   priority:0
								   isSticky:NO
							   clickContext:nil ];
}

@end
