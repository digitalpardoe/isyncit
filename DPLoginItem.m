//
//  DPLoginItem.m
//  iSyncIt
//
//  Created by Alex on 05/06/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "DPLoginItem.h"

@implementation DPLoginItem

- (BOOL)inLoginItems
{
	NSString *appName = [[[NSBundle mainBundle] bundlePath] lastPathComponent];
	NSString *loginWindowPlistPath = [@"~/Library/Preferences/loginwindow.plist" stringByExpandingTildeInPath]; 
	NSMutableDictionary *loginWindowPrefsDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:loginWindowPlistPath];
	NSMutableArray *launchItems = [NSMutableArray arrayWithArray:[loginWindowPrefsDictionary valueForKey:@"AutoLaunchedApplicationDictionary"]];
	
	NSEnumerator *enumerator = [launchItems objectEnumerator];
	id application;
	while ( application = [enumerator nextObject] ) {
		if ( [[[application valueForKey:@"Path"] lastPathComponent] isEqualToString: appName] ) {
			return YES;
		}
	}
	
	return NO;
}

- (void)removeFromLoginItems
{
	NSString *appName = [[[NSBundle mainBundle] bundlePath] lastPathComponent];
	NSString *loginWindowPlistPath = [@"~/Library/Preferences/loginwindow.plist" stringByExpandingTildeInPath]; 
	NSMutableDictionary *loginWindowPrefsDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:loginWindowPlistPath];
	NSMutableArray *launchItems = [NSMutableArray arrayWithArray:[loginWindowPrefsDictionary valueForKey:@"AutoLaunchedApplicationDictionary"]];
	
	NSEnumerator *enumerator = [launchItems objectEnumerator];
	id application;
	while ( application = [enumerator nextObject] ) {
		if ( [[[application valueForKey:@"Path"] lastPathComponent] isEqualToString: appName] ) {
			
			// These 4 lines are run if the app is found in "Login Items".
			// You can replace these lines with something like "return YES;"
			// if you just want a method that checks for your app in the list.
			[launchItems removeObject:application];
			[loginWindowPrefsDictionary setObject:launchItems forKey:@"AutoLaunchedApplicationDictionary"];
			[loginWindowPrefsDictionary writeToFile:loginWindowPlistPath atomically:YES];
			return;
		}
	}
}

- (void)addToLoginItems
{
	NSString *fullPath = [[NSBundle mainBundle] bundlePath];
	NSString *script = [NSString stringWithFormat:@"set appPath to \"%@\" \ntell application \"System Events\" \nmake login item at end with properties {path:appPath, hidden:false} \nend tell", fullPath];
	NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:script];
	[appleScript executeAndReturnError:nil];
	
}

@end
