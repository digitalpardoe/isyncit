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
	NSTimer *timer;
}

- (void)goSchedule;
- (void)startTimer;
- (void)stopTimer;
- (void)tick;

@end
