//
//  NSApplicationAdditions.m
//
//  Created by Cédric Luthi on 13.06.06.
//  Copyright 2006 Cédric Luthi. All rights reserved.
//

#import "NSApplicationAdditions.h"


@implementation NSApplication (NSApplicationAdditions)

- (void)relaunch:(id)sender
{
	NSString *relaunchPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/relaunch.app/Contents/MacOS/relaunch"];
	if (![[NSFileManager defaultManager] isExecutableFileAtPath:relaunchPath]) {
		return;
	}
	[NSTask launchedTaskWithLaunchPath:relaunchPath arguments:[NSArray arrayWithObjects:[[NSBundle mainBundle] executablePath], [NSString stringWithFormat:@"%d", getpid()], nil]];
	[[NSApplication sharedApplication] terminate:sender];
}

@end
