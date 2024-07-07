$RelativeGitDir = '..\..\' # Hard-code the RELATIVE path from the project folder to the .git file.
$RelativeProjectDir = '.\' # Pre-build-event usually put the initial directory to the Project dir.

$RelativeGitDir = $RelativeProjectDir + $RelativeGitDir + '.git\'

if (!(Test-Path $RelativeGitDir)) {
    Write-Host "Not .git in current directory. Powershell script will try reset the location. "
    $RelativeProjectDir = $MyInvocation.MyCommand.Path.ToString()
    $RelativeProjectDir = $RelativeProjectDir.Substring(0, $RelativeProjectDir.length - $RelativeProjectDir.split("\")[-1].length)
    Write-Host "Directory found : $RelativeProjectDir" 
    Set-Location "$RelativeProjectDir".Replace("[", "``[").Replace("]", "``]")
    
    $RelativeGitDir = $RelativeProjectDir + $RelativeGitDir
    if (!(Test-Path $RelativeGitDir)){
        throw "Can't find .git directory. are directory parameters set properly?"
    }
}
else {
    Write-Host ".git\ directory found : $RelativeGitDir"
}
$RelativeCommitNumberDir = $RelativeProjectDir + "CommitNumber.h"

try {
    "#ifndef COMMITNUMBER_H`r`n#define COMMITNUMBER_H`r`n#include <tchar.h>`r`n`r`n" + '#define COMMIT_NUMBER _T("' + (git rev-parse HEAD).ToString() + '") // DO NOT REVISE THIS FILE MANNUALLY. Pre-build event will do it instead of you.' + "`r`n#endif"> $RelativeCommitNumberDir
}
catch {
    throw "Failed to make a header file."
}