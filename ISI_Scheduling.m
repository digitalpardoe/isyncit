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
	
	if ([defaults boolForKey:@"ISI_EnableScheduling"] || [defaults boolForKey:@"ISI_EnableTimedScheduling"]) {
		[self startTimer];
		[self startOtherTimer];
	}
}

- (void)startTimer
{
	start = [NSDate timeIntervalSinceReferenceDate];

	[timer invalidate];
	
	if ([defaults boolForKey:@"ISI_EnableScheduling"]) {
		timer = [NSTimer scheduledTimerWithTimeInterval:([defaults integerForKey:@"ISI_SchedulingSettings"] * 60) target:self selector:@selector(tick) userInfo:NULL repeats:YES];
	}
}

- (void)startOtherTimer
{
	otherStart = [NSDate timeIntervalSinceReferenceDate];
	
	[timedTimer invalidate];
	
	if ([defaults boolForKey:@"ISI_EnableTimedScheduling"]) {
		timedTimer = [NSTimer scheduledTimerWithTimeInterval:(60) target:self selector:@selector(otherTick) userInfo:NULL repeats:YES];
	}
}

- (void)stopTimer
{
	[timer invalidate];
    timer = nil;
}

- (void)stopOtherTimer
{
	[timedTimer invalidate];
	timedTimer = nil;
}

- (void)tick
{
	if ([defaults boolForKey:@"ISI_EnableScheduling"]) {
		syncNow([defaults boolForKey:@"ISI_EnableBluetooth"]);
	}
}

- (void)otherTick
{
	if ([defaults boolForKey:@"ISI_EnableTimedScheduling"]) {
		if ([self timeIsNow]) {
			syncNow([defaults boolForKey:@"ISI_EnableBluetooth"]);
		}
	}
}

- (BOOL) timeIsNow
{
	NSDate *d_then;
	NSDate *d_now;
	
	d_then = (NSDate *) [[defaults objectForKey:@"ISI_TimedSchedulingSettings"] descriptionWithCalendarFormat:@"%H:%M" timeZone:nil locale:nil];
	d_now = (NSDate *) [[NSDate date] descriptionWithCalendarFormat:@"%H:%M" timeZone:nil locale:nil];

	return [d_then isEqual:d_now];
}

@end
