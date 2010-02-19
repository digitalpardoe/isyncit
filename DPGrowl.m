//
//  DPGrowl.m
//  iSyncIt
//
//	See 'LICENSE' for copyright and licensing.
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
