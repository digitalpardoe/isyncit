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
	NSTimeInterval start;
	NSTimeInterval otherStart;
	NSTimer *timer;
	NSTimer *timedTimer;
}

- (void)goSchedule;
- (void)startTimer;
- (void)startOtherTimer;
- (void)stopTimer;
- (void)stopOtherTimer;
- (void)tick;
- (void)otherTick;
- (BOOL)timeIsNow;

@end
