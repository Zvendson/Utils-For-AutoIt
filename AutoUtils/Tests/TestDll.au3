Opt("SetExitCode", 1)

#include ".\..\Dll.au3"

;@Todo Need reword with UnitTest.au3


Global $dDllBinary = _Base64String()
Global $hTestDll   = _Dll_Open($dDllBinary)

If @error Then
	ConsoleWrite("DllOpen Error = "  & @error & @CRLF)
	Exit 1
EndIf



Global $pFuncMakeVector = _Dll_GetProcAddrress($hTestDll, "MakeVector")
Global $pFuncKillVector = _Dll_GetProcAddrress($hTestDll, "KillVector")
Global $pFuncPushInt    = _Dll_GetProcAddrress($hTestDll, "PushInt")
Global $pFuncGetIn      = _Dll_GetProcAddrress($hTestDll, "GetInt")
ConsoleWrite($pFuncMakeVector & @CRLF)
ConsoleWrite($pFuncKillVector & @CRLF)
ConsoleWrite($pFuncPushInt & @CRLF)
ConsoleWrite($pFuncGetIn & @CRLF)



Global $pVector = MakeVector()
ConsoleWrite("Vector at " & $pVector & @CRLF)

PushInt($pVector, 1)
PushInt($pVector, 2)
PushInt($pVector, 4)
PushInt($pVector, 8)

For $i = 0 To 3
    ConsoleWrite("$i = " & GetInt($pVector, $i) & @CRLF)
Next

KillVector($pVector)
_Dll_Close($hTestDll)
ConsoleWrite("closed" & @CRLF)

Func MakeVector()
	If $pFuncMakeVector = 0 Then Return SetError(1, 0, 0)

	Local $aCall = DllCallAddress("PTR:cdecl", $pFuncMakeVector)
	If @error Then
		Return SetError(2, 0, 0)
	EndIf

	Return $aCall[0]
EndFunc


Func KillVector(ByRef $pVector)
	If $pFuncKillVector = 0 Then Return SetError(1, 0, 0)

	DllCallAddress("NONE:cdecl", $pFuncKillVector, "PTR", $pVector)
	If @error Then
		Return SetError(2, 0, 0)
	EndIf

	Return 1
EndFunc


Func PushInt(ByRef $pVector, $nValue)
	If $pFuncPushInt = 0 Then Return SetError(1, 0, 0)

	DllCallAddress("NONE:cdecl", $pFuncPushInt, "PTR", $pVector, "INT", $nValue)
	If @error Then
		Return SetError(2, 0, 0)
	EndIf

	Return 1
EndFunc


Func GetInt(ByRef $pVector, $nIndex)
	If $pFuncGetIn = 0 Then Return SetError(1, 0, 0)

	Local $aCall = DllCallAddress("INT:cdecl", $pFuncGetIn, "PTR", $pVector, "INT", $nIndex)
	If @error Then
		Return SetError(2, 0, 0)
	EndIf

	Return $aCall[0]
EndFunc



;Code below was generated by: 'File to Base64 String' Code Generator v1.20 Build 2020-06-05
Func _Base64String()
	Local $Base64String
	$Base64String &= 'kLoATVqQAAMAAACCBAAw//8AALgAOC0BAEAEOBkA+AAMDh8Aug4AtAnNIbgAAUzNIVRoaXMAIHByb2dyYW0AIGNhbm5vdCAAYmUgcnVuIGkAbiBET1MgbW+AZGUuDQ0KJASGAE3EncAJpfOTQQUDAN1gkw0AB0YQ2faSBgIH95IDEQIH8JIIAgfykgxBAAfa1/KSCwIz8kSTIwAHyNn6Ah/IpNnzBAcMkwMH8QIPMFJpY2gCXwQAUEUAAABMAQUARI4EXmSFCeAAAiELoAEOIgASAAYYgwlUexcAAhCAATACBxBhggUCAAAGhBmFAwCGcASiAAADAEABAhoHgRWGAwMDQDgAAID1gAPAgAN4AkSAO4AWDgCQYAAA/IALKDIDLVkVAGgxjNWAU5SYFy6QdGV4dIADaREESBfBOsQtBQAgQB8ucmSoYXRhgAYNxD4OwAAmFssJwB1ALoMJAAQ3wRABIsBGAAV3xwnALvByc3JjwVjBOsA8wgnCJtATcmVsbwAKwT7rwUDCCSjOCUKgpz8APwAHPwA/ABoAVYvsVosA8Q9XwI1GBFAAxwbYMAAQZg8A1gCLRQiDwAQQUP8VSAACg8QIAIvGXl3CBADMAMyLSQS4CDEAABCFyQ9FwcPMXszjB4AHYwcgBkwiBgQA9kUIAXQLagw4Vuij4ItJCAoAjUHoBMcBKAdZYAoJACATjIvBIBLABEEEHAAPOMcBAKAApgTgD4PsAAyNTfTo0v//AP9oFDgAEI1FwPRQ6K8PAEIN/xt54hvHBqEKUBT/B+QH5MMAAfAHagzoc0BYACISx+Itx0CCbcdACAXBAMPjC3UIhfZ0AFGLBoXAdECLAE4IK8iD4fyBAvnBc3ISi1D8gwDBIyvCg8D8gwD4H3cui8JRULzoUEAKQBYAAGEPRkMKFkZCCiEuMSIOCF5dMMP/FYjgEusZi00ACItRBDtRCHQAC4tFDIkCg0EABARdw41FDFBoUuhNIAhdSTDh'
	$Base64String &= 'BUUACItVDIsIi0AABCvBwfgCO8IID4YV4ASLBJFdJMO44XTCDGYeaDRx4Cj/FTSlDuMzQAhTAFZXi/mJRfiLCBcrwoAIiUX8ixRHBEIBPQA3Pw+EAiQgCYtPCI1wAQAryol19MH5AgK4AQOL0dHqK8IgO8gPh/4gDY0EAAqL3jvGD0PYJIH7wgaH6KACweMIAoH7wiUnjUMjIDvDD4bSoYzo+YECJASFwA+Eu4EHAHAjg+bgiUb8AOsThdt0DVPoAtnjA4vw6wIz9oKLIBJV+I0MhoEiQE38iwCJASAUiwAPO9B1DyvBUBBRVugzYKCDxAyg6yMr0VLAASTAAVkhBE34wAOgB1EhQuiiDoIEGIsHgDks4BkVmTkpgjmDwziLRfQEiTfCD/yJTwSNAAwziU8IX15bQIvlXcIIAOM46MAO/f//6AngBeYzlGhQ4i0w4S07DUCjwBB1AcPp7EBuIC8A6w3/dQjovAyoAABZoBEPgQG1hAGA5l3Dg30I/wAj4Pz//+nOECTwAgEC4uCgAFldw9AAETywL0jHBsTABXQKgSXYGTAXWVlkLqIhDIPoAAB0M4PoAXQgBUEAEUEABTPAQOsIMOhCACrrBegcAWAAD7bA6x//dQYQAQaBdVnrEIN9IBAAD5XAkAFQ6BIMoB9ZXVAkahBoFDA3cA6WMA5qAOhScaADWYTQG9EwA+gAaAUAAIhF47MAAYhd54Nl/AAQgz3QQ2AVD4XFTdEvBcEAwSjonXAChCDAdE3o9AAx6K1J8AzozEAAaKhgDGgypGEUvAtwBVAQdSlE6EXDAiBooNEBnJ3RAZjSAQMF0Wcy2wAHkMdF/P7AD+g9AAGAhNt1Q+huB9AfAPCDPgB0H1boAoiDCnQU/3UMagICUA6LNovO/xWClOAE/9b/BZBgGQExEQ+KXef/deME6O3hAsMzwItNSPBkiQF2AFmQHsmgw2oH6B1gBcxgECpQYRCPAAyhwQOFwAB/BDPA62lI'
	$Base64String &= 'o0GiBP9HiX3kIRDoAlSADYhF4Il9/EHTEAJ1a+gLIA3oksIQIOgf8AODJVISNdICOfFBAEEYAgtZDwC28PfeG/Yj96iJdeQFDiKRPcadCQCLfeT/deDoNMGCC4t15OjJgAfxCqZtEAFATmh48QrfMREAfQyF/3UPOT3BkQp/BzPA6VI28RoA/wF0CoP/AnRABYtdEOsxQABTKlexCMkRB/AgCIX22A+Eo8AAYwGdsC5mATqMZgGLcD9iAeAEdSdAhfZ1I1NQcQFzKXABhdsVJbqwDFlTClaBAWqgA4X/dAWgg/8DdUgzBEKnBRR0NSMBREII6ySLAE3siwFR/zBorDsUsBsRKwzhAYMybIAYw4tl6DP21xJzjxLyXDXIgB+gCYIwE19QBMAgcgQlIfAzDPEzg4B9DAF1Bei+cCu9twaukAVgRiQC8BoVAJgRoTP/FShBKgkEANDA/xUEM3MIYADSOgiB7CQwCmoX/xUCDMEHwHQFagJZAM0po5hBABCJJA2UUQAVkFEAHYxJUQA1iFEAPYRQAGZIjBWwYgANpGIAHZKAYgAFfGIAJXhiAIQtdGAAnI8FqGAAIItFAKOccgAEo4KgcACNRQijrPEARIXcwETHBeiQHwGQAAEAocEBo6TQABjHBZhQAIELxwWcC9IBETuolABqBFhr4MAAx4Cs8AABN/MAQovSTIlMBfjwAMFK4PAABPQAaMxhOuABYBLJw4NhBACLoMGDYQgA8IHscAFcxwGReBERdIHacYGUy+ApcoGX8TXpwVAAEgIgFINl9ACAAYNlFPgA0BQcQXxF+DNBoFhF/P8VGOAAMUWBABSDAI1F7EACEAFCAvCNTfwzRexgM0X8M8HwMcIKVoBXv07mQLu+odQAO890BIXOdSYE6JRxIsg7z3UHJLlPwAHrDlABCg2EEUdga+AQC8jAIyGQA/fRX4nyDV7DxGi48Dr/FSBRDLIAJOjpUje4wLAAw7gSyFEA6O9BBUgE'
	$Base64String &= 'g4AIJIlIBOjn1QAOAtAAoQ/wdlaLSDwAA8gPt0EUjVEIGAPQgAAGa/AoAAPyO9Z0GYtNAAw7SgxyCotCAAgDQgw7yHIMAIPCKDvWdeozAsAwg4vC6/lW6EZiQAdQJCBkoQFbvgLUYAeLUATrBDsE0HSwTIvK8A+xAg4QVPAywF7DsCABXsPoMQMDB+hCUKBB6xjoHfAAUAzoY7ELYAEDMsDDROhcwACwAcOQXdCJYVTAWeA6w+heUAEohMB1EgJSswAH6EpJwWPtwALoP5AA6GY6kwOgDejJ4E2ABxmzsjPCNU0UEUC0NVUwWEAc/3UY6ONwAlkJkGzomAIDdAxo3EXBFORhAcPo7EIBDyyE23AAAQnZYQHp0wNQAGI5CAB1B8YFUtghZeiAoVS5cmJ1qAQywBAFrMMACnADQqFxA+vpsAFCOIBkPdnBVnQE8QB0nQWAg/4BdWLoElMIaiZgQSKTCFShA5AMDxxo6OEAkWiREisywIDrMIPJ/4kNUQJoiQ3gUgDkUgCBAomUDexSAPBQAMYF8QYCAfAXXcNqBejgoZGBaghosMFYUkGgAWBXuE1aAABmOaPQBbCBXaE8YACBUf4CECHwdXi5AEy5CwEAAGY5AIgYAAAQdT6LEEUIuQAASCvBUABR6LP9//9ZWQCFwHQng3gkAAB8IcdF/P7//wD/sAHrH4tF7ACLADPJgTgFAAAAwA+UwYvBwwiLZegEQDLAi00Q8GSJDQCQAFlfAF5bycNVi+zoEBEEAAAAlg+AfQAIAHUJM8C51EBDABCHAV0BHIAEPdgADAB0BoB9AAwAdRL/dQjoFkgALgEHQAAHWVmwQQAnuABEABABLYEA7CQDAABTahdA/xUMMAAQAFQFAItNCM0pagPoAvkAcscEJMwCAAAAjYXc/P//ahAAUOivAC2DxAyIiYWMANCJjYgBBSSVhAEFnYABBbV8CYECvXiAAmaMlaRJAgONmAIDnXQCA4WScAIDpWwC'
	$Base64String &= 'A61oAAMQnI+FnAADi0UEqImFlAAEjQEEoAAEAseCOwEAAQCLQED8alCJhZCCDqgdgUQlgESAGABGx0WogBUAAEDHRawAv4AAiUW0/xUkgGWAagCNWP/32wAXiIlF+INgGtuJAKsQw/8VAIAPjUX4EFD/FSiCenUMhJjbdQgAeoCQAFmAsgiDJfSBosNTVr4gIDcAELsBAjvzAHMZV4s+hf90QAqLz/8VlIAc/wDXg8YEO/Ny6bsAzYEVKMEKAQHdCswAAABodR4AEGT/NQHBdotEJBCJbCQEEI3AACvgU1ZXAKEAQAAQMUX8ADPFUIll6P91MPiLRfzEhIEzRfAMZKPBDcFwVot1CBD/NuhoAGr/dRQAiQb/dRD/dQyAVmjMEwAQaIERBuiAUEBtHF5dw8JEAABADIMl+EE3gyDsJIMNEAAIAWoSCsV/D4RBUYNl8AgAM8CAITPJjX0A3FMPoovzW5AAiQeJdwSJTwgAM8mJVwyLRdwAi33giUX0gfcAR2VudYtF6DUQaW5lScBXi0XkIDVudGVsgCkzwIJAxA6NXdyJA4AwAAtF+AvHiXMEAIlLCIlTDHVDAYARJfA//w89wAAGAQB0Iz1gBkACAHQcPXCBARWAPVAGAwB0DgAFBYABBwAFAwB1EYuEPfzALoPPAYkCAgTrBgMEi03kagcAWIlN/DlF9HwYMDPJyR3DG4tN/IGAHItd4PfDAIBKIHQOg88CxBADiwhd8KEBQoPIAseWBcFGQZKjQQT3wYDwEAAPhJMABIPIBIdDB4APRwcACHR5wgEAEHRxM8kPAdBAiUXsiVXwwXpNAPBqBl4jxjvGdHVXxAsIAwhgVwMI9oDDIHQ7g8ggwwIDIIDDArgAAAPQIyDYO9h1HuAIuuABIURN8CPCO8J1Yg1DNkCJNSEGYEkzGMDJwwAtYAA5BRQBIAMPlcDD/yVAqSFOJTyiAESiAFSiAKpgogBkogCAogB8ogCqXKIAeKIAdKIA'
	$Base64String &= 'cKIAKoyiAGyiAISgALABIwANoU5Rgz0CJXxmAIF9CLQCAMB0CgkAAbUAAXVUD64CXcBA/IPwP6iBEHQ/qQTgJXUHuEKO4JvJw6kCYCt0WCqpCEBtgAKRgwIQTgiiAaAsoQEgEKABDmS4j6IBuJDCAMCpyf3gGlBgEAFfHwAfAB8AHwChCQA8AAAeYAAyYACqRmAAYmAAfGAAkmAAKqhgAMJgANhgAOQ7wcMF7DkAAMxgAAEAoGI6AABMYACCYACqNGAAGmAA+mAFjOAAVQEADmAG3mAB6uQBgNXgAUJgAChgABbhCWAAqvRgA5jgALjgAGRkDA6kQIwfFwMAwDIAEDQYFOMFmMGGYAAIM6FATRAAEDBgAIhoAQBiYWQgYWxsbwBjYXRpb24AAAK8aANVbmtub3eAbiBleGNlcMMDAgDiBXJyYXkgbgBldyBsZW5ndAJo4QxpbnZhbGkAZCB2ZWN0b3IAIHN1YnNjcmkMcHRhA2QCdG9vIPBsb25n5xRfGRcAYBr+7GAV4XuBsmoDgQIfAB4AHvDwBV8BMBX4BkSOXpZkcQCRREEwAEw0MACqGrsBDDAAFDAAkLABVpC8AQGBeMADpLABpL28AQ6vBw8ADwAKAHhwEtbU8CCpEeTwAOw0AfEBy7UBIGn/oxUAADkDAQCqNHACePAQ0DAAVDAAfji0EbkAMQK/BDAG8AEYs9FpvwEArPgDOQpwPAFv8QOxAvUAgVcc+ADxFyz1PANQMAOcMAFxAPEBvQcLsQGgewBgngACgAJ0gAgwGCxxDHAAMQGgFUAAsDAA3zACGx8ABACTMAAIIAAAC1UwAA4wABEwAFYwAF5jMAAwegBkCtBOsAIWFcAG5TABfjAEUlNEAFMu5M0qcwOPAEaK8JJc3Q5LAiwgUgBEOlxQcgBvZ3JhbW1pbgBnXEMrK1xUZQBzdFxSZWxlYYRzZcIALnBkYrUMF6EhMQCxERkwAEdDVAJM0Q5pEQAALnSgZXh0'
	$Base64String &= 'JG3hOQAAkQQAlGAALmlkYXQsYSQyifAxADEHLjBoMGNm4Dec8ADxkS5AQ1JUJFhDYSsAWqA7AVoyRzoBSXICqKs7AXICrDoBUHICsDsB1XICtDoBVHICuLUJMwHNcgLAMAEBHS5yMQzyTEwALIAP8wAkcjJXMzO0BDMBc3ijAjE7AFzBdwF2b2x0bcE0cTkC0DYFJHp6emRiCZFIHDd1BHRjJEmuQTIJMKI4AVoyCSQ5Ab5UcwLwobMLMgFzAjAwAaWBLi4CCSR4siY4cF79cQJl9AzwADEJNBrQDfAFj/BjMUI0AVAMAAA4MAG3uBwQDHNmOMAvNAE2tFDN8iouNBCwMgBg9QDgEqMwPvcBJHJzIQOQMAGSdHEEYnPyAABQNAOAcnNyYyQwMSEBemAwAYByFzIBcgoPAAA2ALGscQDQdAD1AG4Vp/M4/wFzADQW9zonsAAFdQHUeAIQFwAQL78wALJyMGlyKXC58TzccAAW+DAAdQPYeAM3HAAMEEowAHFCJDgAEJ+1AgEEsUS5QPFZIBE7THe5ARAB+gfMcAT1Rb0C4Hs0AjUBkLAeMTuxIzEAaJXwAHgwAIgwACASMAVV8DtgMADwMACZMAGgtTAAqzAAtjAAkQMCkE4BskBkbGwAR2V0AEludABLaWxsglYydQBNYWtlpADwUHVzaNEBMAa0iDIJ1TCEMPA0dDgBpjABAKU0AKQ4AaJwhsChAJS9OAHEMAHgpHIoBQDssIz/MUYPAH+Tf5N/k3+Tf5N/kwd/k3+TcwKPAj9fWABvdXRfb2ZfcgBhbmdlQHN0ZABAQFlBWFBCRDBAWgCO8QFjjF9lEHJyb3LwAfq1AGRAQFlBWFBCAERAWgBNU1ZDAFAxNDAuZGxsAAAAIgBfX3N0AGRfZXhjZXB0AGlvbl9kZXN0IHJveQAhDmRjbwBweQAAAQBfQwB4eFRocm93RREFNAAAJQRadHlwQGVfaW5mbwWOXwBsaXN0AABIACBt'
	$Base64String &= 'ZW1zZQAJNQABBFJfaGFuZGxlJHI0AFhtbQBEVkOAUlVOVElNRQadBDsAAEt2YWxpZABfcGFyYW1ldCBlcl9ubwJfbm8gcmV0dXIAewgAAF9jYWxsbmV3IGgAGQBtAApvY0gAADgBO2l0ADFtBAA5hwVfZQAYAABmcmVlAABBAABfc2VoX2ZpbAsBKwE4GYAkb25maQBndXJlX25hcsGAcV9hcmd2glqBIAppgEV6Bg1lbnZpQHJvbm1lboBrNgGKEG9uZXhpdF9QdGFibIA0JIF5ZWhjdXQMDBeANwEHAAAAYXBpLW1zLQB3aW4tY3J0LQBydW50aW1lLWBsMS0xLQOGjBBoCGVhcAkPAMcFVSpug6hkhstGAm0AACCHBVNldJYHJAKAR2V0Q3VycsAxAFByb2Nlc3MACKYFVABLaW5hdIJlhQQAmwNJcwQDYG9yRmVhQF8AB2UCc4E/YQRRdWVyAHlQZXJmb3JtwGFuY2VDb8AwQBfCJU8XSWQAKUgFwJJIZWFkAAUA+kEFU0B5c3RlbVSAP0EKc0AoZUECAHgDSSkGV1NMgJRIgAwAlAFAJERlYnVnZ2UCckUiS0VSTkVMFDMyQ0VHwZ1tb3YfAGE/AD8APwAyAE7mQMC7sRm/RP8AAOEBQgFkAMQwABDhAS6AP0FWYmFkX0Jn8kDgeEBAagNmgHAD4gYgcnJheV8AcF9s4GVuZ3RoxATqBCaD/wEDHwAfAB8AHwAfAB8AHwBfHwAfAB8AHwAEAAEgoABVYQCA7QICoAAw8AIJAgQhuAAAYFAAAAZ9AUcMADw/eG1sICB2ZXJzYEQ9JwAxLjAnIGVuYwBvZGluZz0nVQBURi04JyBzdAnAj2FsAKA9J3llAHMnPz4NCjxhAHNzZW1ibHkgIQAIbnM9JwC6OnMAY2hlbWFzLW0AaWNyb3NvZnQCLQDEOmFzbS52SDEnIICLaWZgy1YDqQ1ACSAgPHRydVhzdElATKQJIrwJMxYi'
	$Base64String &= '4gYgB3OAs3JpdIZ55AEgAnJlcXWgDEBlZFByaXagkGdsZXOGA8kDReK6ABFMQGV2ZWwgbKEAPQAnYXNJbnZvawBlcicgdWlBYwGBnj0nZmFsc2UoJyAvhwwvtww8L9lqEjwvhhvBJi/lJoABFR8+AKFwIHAbDzAgADA0MEswUjCFADCMMK0wszDPADDvMAAxCTEvADFAMUkx4TFRADJXMqkzwTPHADPOMyQ0kTS9ADTKNOs08DQJADUONRs1XTVlADWYNaI1sDXLADXjNUg2WjYZADdWN3A3pTeuADe5N8A30zfhADfnN+038zf5ADf/NwY4DTgUADgbOCI4KTgwADg4OEA4SDhUADhdOGI4aDhyADh8OIw4nDisADi1OM040zjnADgOOR05JjkzADlJOYM5jDmTADmZOZ85qzmxADkoOsw67DodADtQO3Y7hTucADuiO6g7rju0ADu6O8A71TvqADvxO/c7CTwTADx7PIg8rDy/ADyLPas9tT3OAD3XPdw97z0DAD4IPhs+MT5OAD6QPpU+rD62AD6/Pmg/cT95AD+1P78/yD/RgD/mP+8/ACAwLAFgEh4wJzAwMD4AMEcwaTBwMIMAMI0wkzCZMJ8AMKUwqzCxMLdAML0wwzDJMBPVADDbMOEw8TBlCjEDM5BgAJQwwDAAxDDMMNAw1DAA2DDcMOAw5DAI6DD80BUEMaQxAKgxsDEIMiAyAMwy0DLgMuQyAOwyBDMUMxgzABwzIDMkMywzADAzODNQM1QzAGwzcDOEM5QzAJgzqDO4M8gzAMwz0DPoM0g3AGg3dDeMN5A3AJg3oDeoN6w3AMQ3yDfQN9Q3ANg34Df0N/w3ABA4GDggOCg4WDw4AOBVQVcYkB5QBDB40AkAAA=='
	$Base64String = _WinAPI_Base64Decode($Base64String)
	If @error Then Return SetError(1, 0, 0)
	Local $tSource = DllStructCreate('byte[' & BinaryLen($Base64String) & ']')
	DllStructSetData($tSource, 1, $Base64String)
	Local $tDecompress
	_WinAPI_LZNTDecompress($tSource, $tDecompress, 10752)
	If @error Then Return SetError(3, 0, 0)
	$tSource = 0
	Local Const $dString = Binary(DllStructGetData($tDecompress, 1))
	Return $dString
EndFunc   ;==>_Base64String

Func _WinAPI_Base64Decode($sB64String)
	Local $aCrypt = DllCall("Crypt32.dll", "bool", "CryptStringToBinaryA", "str", $sB64String, "dword", 0, "dword", 1, "ptr", 0, "dword*", 0, "ptr", 0, "ptr", 0)
	If @error Or Not $aCrypt[0] Then Return SetError(1, 0, "")
	Local $bBuffer = DllStructCreate("byte[" & $aCrypt[5] & "]")
	$aCrypt = DllCall("Crypt32.dll", "bool", "CryptStringToBinaryA", "str", $sB64String, "dword", 0, "dword", 1, "struct*", $bBuffer, "dword*", $aCrypt[5], "ptr", 0, "ptr", 0)
	If @error Or Not $aCrypt[0] Then Return SetError(2, 0, "")
	Return DllStructGetData($bBuffer, 1)
EndFunc   ;==>_WinAPI_Base64Decode

Func _WinAPI_LZNTDecompress(ByRef $tInput, ByRef $tOutput, $iBufferSize)
	$tOutput = DllStructCreate("byte[" & $iBufferSize & "]")
	If @error Then Return SetError(1, 0, 0)
	Local $aRet = DllCall("ntdll.dll", "uint", "RtlDecompressBuffer", "ushort", 0x0002, "struct*", $tOutput, "ulong", $iBufferSize, "struct*", $tInput, "ulong", DllStructGetSize($tInput), "ulong*", 0)
	If @error Then Return SetError(2, 0, 0)
	If $aRet[0] Then Return SetError(3, $aRet[0], 0)
	Return $aRet[6]
EndFunc   ;==>_WinAPI_LZNTDecompress