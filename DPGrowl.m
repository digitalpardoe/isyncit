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
	[GrowlApplicationBridge setGrowlDelegate:self];
}

- (void)showGrowlNotification:(NSString *)growlName:(NSString *)growlTitle:(NSString *)growlDescription
{
	[GrowlApplicationBridge notifyWithTitle:growlTitle
								description:growlDescription
						   notificationName:growlName
								   iconData:nil
								   priority:0
								   isSticky:NO
							   clickContext:nil ];
}

@end
