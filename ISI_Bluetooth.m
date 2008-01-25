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

// Set the bluetooth power state using an integer; 0 = off, 1 = on.
int BTSetPowerState(int powerState)
{
	IOBluetoothPreferenceSetControllerPowerState(powerState);
	return EXIT_SUCCESS;
}

// Return the power state with; BTPowerState() ? "on" : "off".
int BTPowerState()
{
	return IOBluetoothPreferenceGetControllerPowerState();
}

@end