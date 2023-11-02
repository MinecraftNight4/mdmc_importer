Folder := A_ScriptDir "\Custom_Albums"
Import := A_InitialWorkingDir
Unzip := Explorer_GetSelection()

if (Import = Folder)
{
	
	
	if Unzip not contains `n
	{
	charttemp := A_Temp "\mdm_" A_NowUTC
	chartzip := A_Temp "\mdm_" A_NowUTC "\_mdm-file.zip"
	FileCreateDir, %charttemp%
	FileCopy, %Unzip%, %chartzip%
	Run PowerShell.exe -NoExit -Command Expand-Archive -LiteralPath '%chartzip%' -DestinationPath %charttemp%,, Hide
	OpenOrActivateFolder(charttemp)
	ExitApp
	}
	else
	{
	ExitApp
	}
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
return








Explorer_GetSelection() {
   WinGetClass, winClass, % "ahk_id" . hWnd := WinExist("A")
   if !(winClass ~= "^(Progman|WorkerW|(Cabinet|Explore)WClass)$")
      Return
   
   shellWindows := ComObjCreate("Shell.Application").Windows
   if (winClass ~= "Progman|WorkerW")  ;
                                       ;
      shellFolderView := shellWindows.Item( ComObject(VT_UI4 := 0x13, SWC_DESKTOP := 0x8) ).Document
   else {
      for window in shellWindows       ;
         if (hWnd = window.HWND) && (shellFolderView := window.Document)
            break
   }
   for item in shellFolderView.SelectedItems
      result .= (result = "" ? "" : "`n") . item.Path
   ;~ if !result
      ;~ result := shellFolderView.Folder.Self.Path
   Return result
}




OpenOrActivateFolder(folderPath) {
   for Window in ComObjCreate("Shell.Application").Windows
      continue
   until Window.document.Folder.Self.Path = folderPath && hWnd := Window.hwnd
   if hWnd
      WinActivate, ahk_id %hWnd%
   else
      Run, % folderPath
}