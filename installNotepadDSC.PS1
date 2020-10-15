<#
.DESCRIPTION
   Powershell DSC script to install NotepadPlusPlus exe file on any machine
.NOTES    
    Name: Install-NotepadDSC.ps1
    Author: Dennis Masinde
    Email : chengwadennismasinde@gmail.com
#>

Configuration InstallNotepadPlusPlus

{

Import-DscResource –ModuleName 'PSDesiredStateConfiguration'

Node Localhost #update the node name to point to the target VM
    {
     #Notepad++
     Package NotepadPlusPlus
     {
     Ensure = 'Present'
     Name = 'Notepad++ (64-bit x64)'
     Path = 'D:\NotepadPlusPlus\npp.7.5.1.Installer.x64.exe' #update the file path
     ProductId = ''
     Arguments = '/S'
    }
    }
}
 
function Invoke-Task {
    param(
        [ValidateScript({
            if(-Not ($_ | Test-Path) ){
                throw "File or folder does not exist"
            }
            if(-Not ($_ | Test-Path -PathType Leaf) ){
                throw "The Path argument must be a file. Folder paths are not allowed."
            }
            if($_ -notmatch "(\.msi|\.exe)"){
                throw "The file specified in the path argument must be either of type msi or exe"
            }
            return $true 
        })]
        [System.IO.FileInfo]$Path
    )
}       

InstallNotepadPlusPlus -OutputPath C:\

Start-DscConfiguration -Path c:\ -Wait -Verbose -Force
