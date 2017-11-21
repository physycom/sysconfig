# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

#Import-Module Pscx
#Invoke-BatchFile "${env:PROGRAMFILES(x86)}\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x64

pushd "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools"
cmd /c "VsDevCmd.bat&set" |
foreach {
  if ($_ -match "=") {
    $v = $_.split("="); set-item -force -path "ENV:\$($v[0])"  -value "$($v[1])"
  }
}
popd
Write-Host "Visual Studio 2017 Command Prompt variables set.`n" -ForegroundColor Yellow

Set-Alias ll Get-ChildItem

Function dos2unix {
Param (
        [Parameter(mandatory=$true)]
        [string[]]$path
      )

  Get-ChildItem -File -Recurse -Path $path |
  ForEach-Object {
    Write-Host "Converting $_" 
    $x = get-content -raw -path $_.fullname; $x -replace "`r`n","`n" | Set-Content -NoNewline -Force -path $_.fullname
  }
}

Function unix2dos {
Param (
        [Parameter(mandatory=$true)]
        [string[]]$path
      )

  Get-ChildItem -File -Recurse -Path $path |
  ForEach-Object {
    Write-Host "Converting $_" 
    $x = get-content -raw -path $_.fullname; $x -replace "`n","`r`n" | Set-Content -NoNewline -Force -path $_.fullname
  }
}

