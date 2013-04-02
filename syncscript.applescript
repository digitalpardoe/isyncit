--
-- syncscript.applescript
--
-- iSyncIt
-- Simple Sync Software
--
-- Created By digital:pardoe
--  

-- Set the location of the bluetooth controller.
property bluetoothcontrolPath : "/usr/local/bin/BluetoothControl"

-- Check the current bluetooth status and turn it on if necessary.
set btWasOn to true
if execBluetoothcontrol("status") ends with "off" then
	set btWasOn to false
	execBluetoothcontrol("on")
end if

-- Open iSync and wait for sync process to complete.
tell application "iSync"
	if not (synchronize) then
		return ("Failed To Start Sync" as string)
	else
		repeat while (syncing is true)
			delay 5
		end repeat
		quit
	end if
end tell

-- Set the bluetooth status to what it was before.
if not btWasOn then execBluetoothcontrol("off")

on execBluetoothcontrol(command)
	set res to do shell script bluetoothcontrolPath & " " & command
	if res contains "Error" then
		display dialog res
		quit
	end if
	return res
end execBluetoothcontrol