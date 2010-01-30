//
//  ISI_Scheduling.h
//  iSyncIt
//
//  Copyright digital:pardoe. All rights reserved.
//

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
