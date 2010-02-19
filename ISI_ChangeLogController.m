//
//  ISI_ChangeLogController.m
//  iSyncIt
//
//	See 'LICENSE' for copyright and licensing.
//


#import "ISI_ChangeLogController.h"

@implementation ISI_ChangeLogController

- (void)awakeFromNib
{
	[changeLog_Out_Window center];
	
	NSBundle * myMainBundle = [NSBundle mainBundle];
	NSString * rtfFilePath = [myMainBundle pathForResource:@"ChangeLog" ofType:@"rtf"];
	[changeLog_Out_TextView readRTFDFromFile:rtfFilePath];
}

- (void)dealloc
{
	[changeLog_Out_Window release];
	[changeLog_Out_TextView release];
	[super dealloc];
}

@end
