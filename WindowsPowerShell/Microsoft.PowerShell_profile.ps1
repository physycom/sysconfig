function getProgramFiles32bit() {
  $out = ${env:PROGRAMFILES(X86)}
  if ($null -eq $out) {
    $out = ${env:PROGRAMFILES}
  }

  if ($null -eq $out) {
    Write-Host "Could not find [Program Files 32-bit]" -ForegroundColor Yellow
  }

  return $out
}

function getLatestVisualStudioWithDesktopWorkloadPath() {
  $programFiles = getProgramFiles32bit
  $vswhereExe = "$programFiles\Microsoft Visual Studio\Installer\vswhere.exe"
  if (Test-Path $vswhereExe) {
    $output = & $vswhereExe -products * -latest -requires Microsoft.VisualStudio.Workload.NativeDesktop -format xml
    [xml]$asXml = $output
    foreach ($instance in $asXml.instances.instance) {
      $installationPath = $instance.InstallationPath -replace "\\$" # Remove potential trailing backslash
    }
    if (!$installationPath) {
      Write-Host "Warning: no full Visual Studio setup has been found, extending search to include also partial installations" -ForegroundColor Yellow
      $output = & $vswhereExe -products * -latest -format xml
      [xml]$asXml = $output
      foreach ($instance in $asXml.instances.instance) {
        $installationPath = $instance.InstallationPath -replace "\\$" # Remove potential trailing backslash
      }
    }
    if (!$installationPath) {
      Write-Host "Could not locate any installation of Visual Studio" -ForegroundColor Yellow
    }
  }
  else {
    Write-Host "Could not locate vswhere at $vswhereExe" -ForegroundColor Yellow
  }
  return $installationPath
}

if ($null -eq (Get-Command "cl.exe" -ErrorAction SilentlyContinue)) {
  $vsfound = getLatestVisualStudioWithDesktopWorkloadPath
  Write-Host "Found VS in ${vsfound}"
  Push-Location "${vsfound}\Common7\Tools"
  cmd.exe /c "VsDevCmd.bat -arch=x64 & set" |
  ForEach-Object {
    if ($_ -match "=") {
      $v = $_.split("="); Set-Item -force -path "ENV:\$($v[0])"  -value "$($v[1])"
    }
  }
  Pop-Location
  Write-Host "Visual Studio Command Prompt variables set" -ForegroundColor Yellow
}

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
    $x = get-content -raw -path $_.fullname
    $SearchStr = [regex]::Escape("`r`n")
    $SEL = Select-String -InputObject $x -Pattern $SearchStr
    if ($SEL -ne $null)
    {
        Write-Host "Converting $_"
        # do nothing: avoid creating files containing `r`r`n when using unix2dos twice on the same file
    }
    else
    {
        Write-Host "Converting $_"
         $x -replace "`n","`r`n" | Set-Content -NoNewline -Force -path $_.fullname
    }
  }
}

function gg++()
{
    $compiler = Get-Command cl.exe -ErrorAction SilentlyContinue
    If ( $compiler -eq $null )
    {
        Write-Host "Unable to find MSVC compiler" -ForegroundColor Red
        exit
    }
    $cmd = "cl.exe "
    Foreach ($i in $args)
    {
        if ( $i.Contains(".cpp") )
        {
            $file = $i
        }
        $cmd += $i + " "
        $flags += $i + " "
    }
    $cmd += "/EHsc /nologo" # silent verbose compile
    $cmd = $cmd -creplace "-o ", "/Fe" # pay attention to space!

    # optimizations
    $cmd = $cmd -creplace "-O0", "/Od"
    $cmd = $cmd -creplace "-Os", "/O1 /Os"
    $cmd = $cmd -creplace "-O1", "/O2 /Ot"
    $cmd = $cmd -creplace "-O2", "/O2 /Ot"
    $cmd = $cmd -creplace "-O3", "/Ox"

    # warnings
    $cmd = $cmd -creplace "-Wall", "/W3"
    $cmd = $cmd -creplace "-Wextra", "/Wall"
    $cmd = $cmd -creplace "-Werror", "/WX"

    # standard
    $cmd = $cmd.Replace("-std=c++11", "") # already included
    $cmd = $cmd.Replace("-std=gnu++11", "") # already included
    $cmd = $cmd.Replace("-std=c++14", "/std:c++14")
    $cmd = $cmd.Replace("-std=gnu++14", "/std:c++latest")
    $cmd = $cmd.Replace("-std=c++17", "/std:c++17")
    $cmd = $cmd.Replace("-std=gnu++17", "/std:c++latest")

    # include
    $cmd = $cmd -creplace "-I", "/I"
    $cmd = $cmd -creplace "-include", "/FI"

    # OpenMP
    $cmd = $cmd.Replace("-fopenmp", "/openmp")

    # I DONT KNOW
    $cmd = $cmd.Replace("-shared", "/LD")
    $cmd = $cmd.Replace("-g", "/Zi")
    $cmd = $cmd.Replace("-xc", "/TC")
    $cmd = $cmd.Replace("-xc++", "/TP")
    $cmd = $cmd.Replace("--whole-archive", "/wholearchive")
    $cmd = $cmd -creplace "-fno-rtti", "/GR-"
    $cmd = $cmd -creplace "-fno-threadsafe-statics", "/Zc:threadSafeInit-"
    $cmd = $cmd -creplace "-fno-inline", "/Ob0"
    $cmd = $cmd -creplace "-fno-stack-protector", "/Gs- /guard:cf-"
    $cmd = $cmd -creplace "-fno-stack-check", "/Gs- /guard:cf-"
    $cmd = $cmd -creplace "-fno-sized-deallocation", "/Zc:sizedDealloc-"
    $cmd = $cmd -creplace "-fno-whole-program", "/Gl-"
    $cmd = $cmd -creplace "-fomit-frame-pointer", "/Oy"
    $cmd = $cmd -creplace "-fpermissive", "/permissive"
    $cmd = $cmd -creplace "-fstack-protector", "/Gs"
    $cmd = $cmd -creplace "-fstack-check", "/Gs"
    $cmd = $cmd -creplace "-fstack-protector-strong", "/Gs /guard:cf"
    $cmd = $cmd -creplace "-fstack-protector-all", "/Gs /guard:cf"
    $cmd = $cmd -creplace "-finline-functions", "/Ob2"
    $cmd = $cmd -creplace "-frtti", "/GR"
    $cmd = $cmd -creplace "-fthreadsafe-statics", "/Zc:threadSafeInit"
    $cmd = $cmd -creplace "-funsigned-char", "/J"
    $cmd = $cmd -creplace "-fsized-deallocation", "/Zc:sizedDealloc"

    Write-Host $flags.Replace($file, "") " " -> $cmd.Replace("cl.exe", "").Replace($file, "").Replace("/EHsc", "").Replace("/nologo", "") -ForegroundColor Green
    Invoke-Expression $cmd
}
