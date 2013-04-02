/*
 * ISI_PrefItems.h
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import <Cocoa/Cocoa.h>


@interface ISI_PrefItems : NSObject
{
    IBOutlet id window;
	IBOutlet NSView *prefsPanel1;
    IBOutlet NSView *prefsPanel2;
	IBOutlet NSView *prefsPanel3;
	
	NSMutableDictionary *toolbarItems;
		
	NSRect panel1Bounds;
	NSRect panel2Bounds;
	NSRect panel3Bounds;

}

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag;
- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar*)toolbar;
- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar*)toolbar;
- (NSArray *)toolbarSelectableItemIdentifiers: (NSToolbar *)toolbar;

@end