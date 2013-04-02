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

// Set the blueooth power state.
int BTSetPowerState(int powerState)
{
	
	// Use the private framework to control blutooth (naughty, naughty).
	IOBluetoothPreferenceSetControllerPowerState(powerState);
	return EXIT_SUCCESS;
	
}

// Get the bluetooth power state.
int BTPowerState()
{
	
	// Boring bit, yawn.
	return IOBluetoothPreferenceGetControllerPowerState();
	
}

@end