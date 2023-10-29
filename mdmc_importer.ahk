Folder := A_ScriptDir "\Custom_Albums"
Import := A_InitialWorkingDir

if (Import = Folder)
{
    MsgBox Maybe this is not a good idea...
    ExitApp
}

else if (Import " " = "C:\WINDOWS\System32 ")
{
    ExitApp
}

else if !FileExist(Folder)
{
    MsgBox SOMETHING SEEMS OUT OF PLACE!`nYou can try to fix it this way:`n`n1) Put the file inside the same folder where "MuseDash.exe" is.`n2) Right click on any ".mdm" file and click on "Select another program".`n3) Select "mdmc.exe" and that's it!
    ExitApp
}

else
{
	FileAppend, [%A_YYYY%/%A_MM%/%A_DD% %A_Hour%:%A_Min%:%A_Sec%.%A_MSec%]: File(s) detected at %A_InitialWorkingDir%:`n, %A_ScriptDir%\MelonLoader\mdm_import.log
    Loop Files, %A_InitialWorkingDir%\*.mdm, R
    {
        WriteFile := A_ScriptDir "\Custom_Albums\" A_LoopFileName
		if FileExist(WriteFile)
        {
        FileAppend, |     - %A_LoopFileName% [REPLACED]`n, %A_ScriptDir%\MelonLoader\mdm_import.log
        FileMove, %A_InitialWorkingDir%\%A_LoopFileName%, %A_ScriptDir%\Custom_Albums, 1
		}
        
		else
        {
		FileAppend, |     - %A_LoopFileName% `n, %A_ScriptDir%\MelonLoader\mdm_import.log
        FileMove, %A_InitialWorkingDir%\%A_LoopFileName%, %A_ScriptDir%\Custom_Albums, 1
		}
    }
    ExitApp
}