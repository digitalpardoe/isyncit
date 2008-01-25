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
#import "ISI_Sync.h"

@interface ISI_Scheduling : NSObject
{
	NSUserDefaults *defaults;
	NSTimeInterval start;
	NSTimeInterval otherStart;
	NSTimer *timer;
	NSTimer *timedTimer;
	
	ISI_Sync *syncControl;
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
