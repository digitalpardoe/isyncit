/*
 * ISI_Sync.h
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import <Cocoa/Cocoa.h>
#import "DPGrowl.h"

@interface ISI_Sync : NSObject
{
}

+ (void)startSync : (BOOL)defaultsValue;

@end
