/*
 * ISI_PrefController.h
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import <Cocoa/Cocoa.h>

@interface ISI_PrefController : NSObject
{
    IBOutlet NSButton *pref_Out_BTControlOption;
}

- (IBAction)pref_Act_PerformCleanup:(id)sender;

@end
