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
	
	if ([defaults boolForKey:@"ISI_EnableScheduling"])
	{
		[self startIntervalTimer];
	}
	
	if ([defaults boolForKey:@"ISI_EnableTimedScheduling"]) 
	{
		[self startScheduleTimer];
	}
}

- (void)startIntervalTimer
{
	intervalStart = [NSDate timeIntervalSinceReferenceDate];

	[intervalTimer invalidate];
	
	if ([defaults boolForKey:@"ISI_EnableScheduling"]) {
		intervalTimer = [NSTimer scheduledTimerWithTimeInterval:([defaults integerForKey:@"ISI_SchedulingSettings"] * 60) target:self selector:@selector(intervalTick) userInfo:NULL repeats:YES];
	}
}

- (void)startScheduleTimer
{
	scheduleStart = [NSDate timeIntervalSinceReferenceDate];
	
	[scheduleTimer invalidate];
	
	if ([defaults boolForKey:@"ISI_EnableTimedScheduling"]) {
		scheduleTimer = [NSTimer scheduledTimerWithTimeInterval:(60) target:self selector:@selector(scheduleTick) userInfo:NULL repeats:YES];
	}
}

- (void)stopIntervalTimer
{
	[intervalTimer invalidate];
    intervalTimer = nil;
}

- (void)stopScheduleTimer
{
	[scheduleTimer invalidate];
	scheduleTimer = nil;
}

- (void)intervalTick
{
	if ([defaults boolForKey:@"ISI_EnableScheduling"]) {
		[ISI_Sync startSync : [defaults boolForKey:@"ISI_EnableBluetooth"]];
	}
}

- (void)scheduleTick
{
	if ([defaults boolForKey:@"ISI_EnableTimedScheduling"]) {
		if ([self timeIsNow]) {
			[ISI_Sync startSync : [defaults boolForKey:@"ISI_EnableBluetooth"]];
		}
	}
}

- (BOOL)timeIsNow
{
	NSDate *d_then;
	NSDate *d_now;
	
	d_then = (NSDate *) [[defaults objectForKey:@"ISI_TimedSchedulingSettings"] descriptionWithCalendarFormat:@"%H:%M" timeZone:nil locale:nil];
	d_now = (NSDate *) [[NSDate date] descriptionWithCalendarFormat:@"%H:%M" timeZone:nil locale:nil];

	return [d_then isEqual:d_now];
}

- (void)dealloc
{
	[defaults release];
	[intervalTimer release];
	[scheduleTimer release];
	[super dealloc];
}

@end
