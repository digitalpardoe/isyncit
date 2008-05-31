//
//  DPGrowl.m
//  iSyncIt
//
//  Created by Alex on 31/05/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "DPGrowl.h"

int numberMessages;

@implementation DPGrowl

- (void)initializeGrowl : (int)noMessages;
{
	numberMessages = noMessages;
	
	growlReady = YES;
	
	// Tells the Growl framework that this class will receive callbacks
	[GrowlApplicationBridge setGrowlDelegate:self];
	[self registrationDictionaryForGrowl];
}

- (NSDictionary *)registrationDictionaryForGrowl
{
	// For this application, only one notification is registered
	NSArray* defaultNotifications = [NSArray arrayWithObjects: nil];
	NSArray* allNotifications = [NSArray arrayWithObjects: nil];
	
	int n = 1;
	
	while (n <= numberMessages)
	{
		defaultNotifications = [defaultNotifications arrayByAddingObject:[NSString stringWithFormat:@"%i", n]];
		allNotifications = [allNotifications arrayByAddingObject:[NSString stringWithFormat:@"%i", n]];
		n++;
	}
	
	NSDictionary* growlRegistration = [NSDictionary dictionaryWithObjectsAndKeys: 
									   defaultNotifications, GROWL_NOTIFICATIONS_DEFAULT,
									   allNotifications, GROWL_NOTIFICATIONS_ALL, nil];
	
	return growlRegistration;
}

- (void)growlIsReady
{
	// Only get called when Growl is starting. Not called when Growl is already running so we leave growlReady to YES by default...
	growlReady = YES;
}

- (NSString *)applicationNameForGrowl
{
	return [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"];
}

- (void)showGrowlNotification : (NSString *)growlName : (NSString *)growlTitle : (NSString *)growlDescription
{
	if (!growlReady)
	{
		return;
	}
	
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
