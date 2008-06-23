/*
 * ISI_Scheduling.h
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import <Cocoa/Cocoa.h>

@interface ISI_Scheduling : NSObject
{
	NSUserDefaults *defaults;
	NSTimeInterval intervalStart;
	NSTimeInterval scheduleStart;
	NSTimer *intervalTimer;
	NSTimer *scheduleTimer;
}

- (void)goSchedule;

- (void)startIntervalTimer;

- (void)startScheduleTimer;

- (void)stopIntervalTimer;

- (void)stopScheduleTimer;

- (void)intervalTick;

- (void)scheduleTick;

- (BOOL)timeIsNow;

@end
