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
	IBOutlet NSView *prefsPanel3;
	IBOutlet NSView *prefsPanel4;
	IBOutlet NSView *prefsPanel5;
	IBOutlet NSView *prefsPanel6;
	
	NSMutableDictionary *toolbarItems;
		
	NSRect panel1Bounds;
	NSRect panel3Bounds;
	NSRect panel4Bounds;
	NSRect panel5Bounds;
	NSRect panel6Bounds;
}

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag;

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar*)toolbar;

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar*)toolbar;

- (NSArray *)toolbarSelectableItemIdentifiers: (NSToolbar *)toolbar;

@end