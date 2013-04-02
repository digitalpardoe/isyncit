/*
 * ISI_PrefItems.m
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import "ISI_PrefItems.h"

static void addToolbarItem(NSMutableDictionary *theDict,NSString *identifier,NSString *label,NSString *paletteLabel,NSString *toolTip,id target,SEL settingSelector,id itemContent,SEL action,NSMenu * menu)
{
	// Initialises variables and adds toolbar items.
    NSMenuItem *mItem;
    NSToolbarItem *item = [[[NSToolbarItem alloc] initWithItemIdentifier:identifier] autorelease];
    [item setLabel:label];
    [item setPaletteLabel:paletteLabel];
    [item setToolTip:toolTip];
    [item setTarget:target];
	[item performSelector:settingSelector withObject:itemContent];
    [item setAction:action];
	
    if (menu!=NULL) {
		mItem=[[[NSMenuItem alloc] init] autorelease];
		[mItem setSubmenu: menu];
		[mItem setTitle: [menu title]];
		[item setMenuFormRepresentation:mItem];
    }
	
	[theDict setObject:item forKey:identifier];
}


float ToolbarHeightForWindow(NSWindow *window)
{
	// Calculates the toolbar height so it doesn't look out of proportion.
    NSToolbar *toolbar;
    float toolbarHeight = 0.0;
    NSRect windowFrame;
    toolbar = [window toolbar];
    
	if(toolbar && [toolbar isVisible]) {
		windowFrame = [NSWindow contentRectForFrameRect:[window frame]
											  styleMask:[window styleMask]];
        toolbarHeight = NSHeight(windowFrame) - NSHeight([[window contentView] frame]);
    }
	
    return toolbarHeight;
}


void showPanelNumber(int panelNumber, NSRect viewBounds, NSView *viewPanel, NSString * windowTitle, NSWindow *window)
{
   // Displays a preference panel and re-sizes the window.
   NSRect windowFrame = [NSWindow contentRectForFrameRect:[window frame] 
												styleMask:[window styleMask]];
   
   NSRect newWindowFrame = [NSWindow frameRectForContentRect:NSMakeRect(NSMinX( windowFrame ),
																		NSMaxY( windowFrame )
																		- viewBounds.size.height
																		- ToolbarHeightForWindow(window),
																		viewBounds.size.width,
																		viewBounds.size.height
																		+ ToolbarHeightForWindow(window))
																		styleMask:[window styleMask]];
   
   [window setTitle: windowTitle];
   [window setContentView:viewPanel];
   [window setFrame:newWindowFrame display:YES animate:YES];
}


@implementation ISI_PrefItems

- (IBAction) showPanel1:(id)sender {
	showPanelNumber(1, panel1Bounds, prefsPanel1, @"Bluetooth", window);
}
   
- (IBAction) showPanel2:(id)sender {
	showPanelNumber(2, panel2Bounds, prefsPanel2, @"Old Files", window);
}

- (IBAction) showPanel3:(id)sender {
	showPanelNumber(3, panel3Bounds, prefsPanel3, @"Updates", window);
}

- (IBAction) showPanel4:(id)sender {
	showPanelNumber(4, panel4Bounds, prefsPanel4, @"Login Item", window);
}


-(void)awakeFromNib
{
	// Initialise the toolbar items and set up the toolbar.
	panel1Bounds = [prefsPanel1 bounds];
	panel2Bounds = [prefsPanel2 bounds];
	panel3Bounds = [prefsPanel3 bounds];
	panel4Bounds = [prefsPanel4 bounds];

	NSToolbar *toolbar=[[[NSToolbar alloc] initWithIdentifier:@"myToolbar"] autorelease];

	toolbarItems=[[NSMutableDictionary dictionary] retain];
                                                                                                                                                                                                                                       
	addToolbarItem(toolbarItems,@"BluetoothPrefs",@"Bluetooth",@"Bluetooth",@"This allows bluetooth control options to be set.",self,@selector(setImage:),[NSImage imageNamed:@"ISI_Bluetooth.tif"],@selector(showPanel1:),NULL);
	addToolbarItem(toolbarItems,@"OldFilesPrefs",@"Old Files",@"Old Files",@"This allows files from previous version to be removed.",self,@selector(setImage:),[NSImage imageNamed:@"ISI_OldFiles.tif"],@selector(showPanel2:),NULL);
	addToolbarItem(toolbarItems,@"UpdatePrefs",@"Updates",@"Updates",@"This allows updates to be controlled.",self,@selector(setImage:),[NSImage imageNamed:@"ISI_Updates.tif"],@selector(showPanel3:),NULL);
	addToolbarItem(toolbarItems,@"LoginPrefs",@"Login Item",@"LoginPrefs",@"This allows the login item to be installed.",self,@selector(setImage:),[NSImage imageNamed:@"ISI_LoginItem.tif"],@selector(showPanel4:),NULL);

	// Set the toolbar options.
	[toolbar setDelegate:self];
	[toolbar setAllowsUserCustomization:YES];
	[toolbar setAutosavesConfiguration:YES];

	[toolbar setDisplayMode: NSToolbarDisplayModeIconAndLabel];
	[toolbar setSizeMode:NSToolbarSizeModeRegular];

	[toolbar setSelectedItemIdentifier:@"BluetoothPrefs"];

	[self showPanel1:nil];
   
	[window setToolbar:toolbar];
	[window center];
}

-(BOOL)validateMenuItem:(NSMenuItem *)menuItem
{
	return YES;
}


- (BOOL)validateToolbarItem:(NSToolbarItem *)theItem
{
    return YES;
}


- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag
{
	// The toolbar array & property filling process.
	NSToolbarItem *newItem = [[[NSToolbarItem alloc]
	initWithItemIdentifier:itemIdentifier] autorelease];
    NSToolbarItem *item=[toolbarItems objectForKey:itemIdentifier];

	[newItem setLabel:[item label]];
    [newItem setPaletteLabel:[item paletteLabel]];

	if ([item view]!=NULL) {
		[newItem setView:[item view]];
	} else {
		[newItem setImage:[item image]];
    }

	[newItem setToolTip:[item toolTip]];
    [newItem setTarget:[item target]];
    [newItem setAction:[item action]];
    [newItem setMenuFormRepresentation:[item menuFormRepresentation]];

	if ([newItem view]!=NULL) {
		[newItem setMinSize:[[item view] bounds].size];
		[newItem setMaxSize:[[item view] bounds].size];
	}

	return newItem;
}

- (NSArray *)toolbarSelectableItemIdentifiers: (NSToolbar *)toolbar;
{
	return [NSArray arrayWithObjects:@"BluetoothPrefs",@"OldFilesPrefs",@"UpdatePrefs",@"LoginPrefs",nil];
}

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar*)toolbar
{
	// Can also have: NSToolbarSeparatorItemIdentifier.
	return [NSArray arrayWithObjects:@"BluetoothPrefs",@"OldFilesPrefs",@"LoginPrefs",NSToolbarSeparatorItemIdentifier,@"UpdatePrefs",nil];
}


- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar*)toolbar
{
	// Can also have: NSToolbarSeparatorItemIdentifier.
    return [NSArray arrayWithObjects:@"BluetoothPrefs",@"OldFilesPrefs",@"LoginPrefs",@"UpdatePrefs",NSToolbarSeparatorItemIdentifier,NSToolbarFlexibleSpaceItemIdentifier,NSToolbarSpaceItemIdentifier,NSToolbarCustomizeToolbarItemIdentifier,nil];
}

- (void)dealloc
{
	// De-allocate the necessary resources.
	[toolbarItems release];
    [super dealloc];
}

@end
