#include ".\..\Vector.au3"


Local $hStopwatch = TimerInit()
Test()
ConsoleWrite("Time passed: " & TimerDiff($hStopwatch) & "ms" & @CRLF)



Func Test()
    Local $aVector1 = _Vector_Init()
	For $i = 1 To 10
		_Vector_Push($aVector1, "Henlo " & $i)
	Next

    Local $aVector2 = _Vector_Init()
	For $i = 1 To 10
		_Vector_Push($aVector2, "Test " & $i)
	Next

    PrintVector($aVector1, "Vector 1")
    PrintVector($aVector2, "Vector 2")

    _Vector_Swap($aVector1, $aVector2)
	ConsoleWrite(@LF & "<<Swap>>" & @LF & @LF)


    PrintVector($aVector1, "Vector 1")
    PrintVector($aVector2, "Vector 2")

	_Vector_AddVector($aVector1, $aVector2)
	ConsoleWrite(@LF & "<<AddVector>>" & @LF & @LF)
    PrintVector($aVector1, "Vector 1")
    PrintVector($aVector2, "Vector 2")
EndFunc



Func PrintVector(Const ByRef $aVector, Const $nTitle = "Vector")
    If Not _Vector_IsVector($aVector) Then
		Return
	EndIf

	ConsoleWrite("[" & $nTitle & "]" & @LF)

	For $i = 0 To _Vector_GetSize($aVector) - 1
		ConsoleWrite(StringFormat("%5d = %s", $i, _Vector_Get($aVector, $i)) & @LF)
	Next

EndFunc