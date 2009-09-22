/*
 * ISI_Bluetooth.m
 *
 * iSyncIt
 * Simple Sync Software
 * 
 * Created By digital:pardoe
 * 
 */

#import "ISI_Bluetooth.h"

@implementation ISI_Bluetooth

+ (void)setPowerState:(int)state
{
	if ([self available])
	{
		IOBluetoothPreferenceSetControllerPowerState(state);
		[self _message];
	}
}

+ (int)getPowerState
{
	if ([self available])
	{
		return IOBluetoothPreferenceGetControllerPowerState();
	} else {
		return 0;
	}
}

+ (void)togglePowerState
{
	if ([self available])
	{
		if ([self getPowerState] == 0)
		{
			[self setPowerState:1];
		} else {
			[self setPowerState:0];
		}
	}
}

+ (BOOL)available
{
	if (IOBluetoothPreferencesAvailable())
	{
		return YES;
	} else {
		return NO;
	}
}

+ (void)_message
{
	SInt32 version;
	Gestalt(gestaltSystemVersionMinor, &version);
	
	if (version <= 5) {
		if ([self getPowerState] == 0)
		{
			[[DPGrowl theGrowl] showGrowlNotification : @"Bluetooth Off" : @"Bluetooth Off" : @"Your bluetooth hardware has been turned off."];
		} else {
			[[DPGrowl theGrowl] showGrowlNotification : @"Bluetooth On" : @"Bluetooth On" : @"Your bluetooth hardware has been turned on."];
		}
	} else if (version >= 6) {
		if ([self getPowerState] == 1)
		{
			[[DPGrowl theGrowl] showGrowlNotification : @"Bluetooth Off" : @"Bluetooth Off" : @"Your bluetooth hardware has been turned off."];
		} else {
			[[DPGrowl theGrowl] showGrowlNotification : @"Bluetooth On" : @"Bluetooth On" : @"Your bluetooth hardware has been turned on."];
		}
	}

}

@end