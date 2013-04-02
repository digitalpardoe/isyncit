/*
 * ISI_Scheduling.m
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import "ISI_Scheduling.h"

@implementation ISI_Scheduling

- (void)goSchedule
{
	defaults = [NSUserDefaults standardUserDefaults];
	
	if ([defaults boolForKey:@"ISI_EnableScheduling"]) {
		[self startTimer];
	}
}

- (void)startTimer
{
	start = [NSDate timeIntervalSinceReferenceDate];
	[timer invalidate];
	timer = [NSTimer scheduledTimerWithTimeInterval:([defaults integerForKey:@"ISI_SchedulingSettings"] * 60) target:self selector:@selector(tick) userInfo:NULL repeats:YES];
}

- (void)stopTimer
{
	[timer invalidate];
    timer = nil;
}

- (void)tick
{
	syncNow([defaults boolForKey:@"ISI_EnableBluetooth"]);
}

@end
