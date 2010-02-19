//
//  DPLoginItem.m
//  iSyncIt
//
//	See 'LICENSE' for copyright and licensing.
//

#import "DPLoginItem.h"

@implementation DPLoginItem

+ (BOOL)inLoginItems
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

+ (void)removeFromLoginItems
{
	NSString *appName = [[[NSBundle mainBundle] bundlePath] lastPathComponent];
	NSString *loginWindowPlistPath = [@"~/Library/Preferences/loginwindow.plist" stringByExpandingTildeInPath]; 
	NSMutableDictionary *loginWindowPrefsDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:loginWindowPlistPath];
	NSMutableArray *launchItems = [NSMutableArray arrayWithArray:[loginWindowPrefsDictionary valueForKey:@"AutoLaunchedApplicationDictionary"]];
	
	NSEnumerator *enumerator = [launchItems objectEnumerator];
	id application;
	while ( application = [enumerator nextObject] ) {
		if ( [[[application valueForKey:@"Path"] lastPathComponent] isEqualToString: appName] ) {
			[launchItems removeObject:application];
			[loginWindowPrefsDictionary setObject:launchItems forKey:@"AutoLaunchedApplicationDictionary"];
			[loginWindowPrefsDictionary writeToFile:loginWindowPlistPath atomically:YES];
			return;
		}
	}
}

+ (void)addToLoginItems
{
	NSString *fullPath = [[NSBundle mainBundle] bundlePath];
	NSString *script = [NSString stringWithFormat:@"set appPath to \"%@\" \ntell application \"System Events\" \nmake login item at end with properties {path:appPath, hidden:false} \nend tell", fullPath];
	NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:script];
	[appleScript executeAndReturnError:nil];
	[appleScript release];
}

@end
