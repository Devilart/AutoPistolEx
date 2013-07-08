

#Include <Misc.au3>
#include "EnhancedMouseClick.au3"

HotKeySet("{F10}", "_exit")

Global $fActiv = False
Global $dll = DllOpen("user32.dll")

FileInstall(".\activated.wav", @TempDir & "\activated.wav", 1)
FileInstall(".\deactivated.wav", @TempDir & "\deactivated.wav", 1)

While 1
	If _IsPressed("7A", $dll) Then
		While _IsPressed("7A", $dll) = True
			Sleep(100)
		WEnd
		If $fActiv = True Then
			$fActiv = False
			SoundPlay(@TempDir & "\deactivated.wav")
		Else
			$fActiv = True
			SoundPlay(@TempDir & "\activated.wav")
		EndIf
	EndIf
	If $fActiv = True Then
		_AutoPistol()
	EndIf
WEnd

Func _AutoPistol()
	Local $iSleep, $goTimer
	Local $iBurst, $iRecoil, $iRecSpeed
	Local $sDownKey
;~ 		$sKey = "51"
	If _IsPressed("01", $dll) Then
		_KeyDownManager("Mouse5")
		While _IsPressed("01", $dll) = 1
			ControlClick("", "", "", "left")
		WEnd
		_KeyUpManager("Mouse5")
	EndIf
EndFunc   ;==>_AutoPistol

Func _exit()
	DllClose($dll)
	FileDelete(@TempDir & "\activated.wav")
	FileDelete(@TempDir & "\deactivated.wav")
	Exit
EndFunc

Func _KeyDownManager($sBut)
	Switch $sBut
		Case "Mouse1"
			_EnhancedMouseDown($dll, "left")
		Case "Mouse2"
			_EnhancedMouseDown($dll, "right")
		Case "Mouse3"
			_EnhancedMouseDown($dll, "middle")
		Case "Mouse4"
			_EnhancedMouseDown($dll, "x1")
		Case "Mouse5"
			_EnhancedMouseDown($dll, "x2")
	EndSwitch
EndFunc   ;==>_KeyDownManager

Func _KeyUpManager($sBut)
	Switch $sBut
		Case "Mouse1"
			_EnhancedMouseUp($dll, "left")
		Case "Mouse2"
			_EnhancedMouseUp($dll, "right")
		Case "Mouse3"
			_EnhancedMouseUp($dll, "middle")
		Case "Mouse4"
			_EnhancedMouseUp($dll, "x1")
		Case "Mouse5"
			_EnhancedMouseUp($dll, "x2")
	EndSwitch
EndFunc   ;==>_KeyUpManager