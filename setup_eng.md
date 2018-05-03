# Prerequisites for the code building

## Ubuntu On Windows

It is better to use Bash on Ubuntu on Windows only from build 15063 (Creators Update).
1) If not already installed, please install [chocolatey](http://chocolatey.org)
2) If not already installed, please install an X server with this procedure: open Powershell with Administrator privileges and write

```PowerShell
PS \>  cinst -y vcxsrv
```

3) Run VcXsrv (it is necessary to keep it open whenever you need any graphical process inside Bash!)
4) If it not already enabled, turn on UoW following the [official guide](https://msdn.microsoft.com/it-it/commandline/wsl/install_guide)
5) Open Ubuntu and enable the graphics through VcXsrv with this command

```bash
echo -e "\n export DISPLAY=localhost:0.0 \n" >> ~/.bashrc
```

6) Close the Bash and follow now the Ubuntu guide

## Ubuntu

1) Define a work folder, which we will call WORKSPACE in this tutorial: this could be a "Code" folder in our home, a "c++" folder on our desktop, whatever you want. Create it if you don't already have, using your favourite method (mkdir in bash, or from the graphical interface of your distribution). We will now define an environment variable to tell the system where our folder is. Please note down the full path of this folder, which will look like `/home/$(whoami)/code/`
2) Open a Bash terminal and type the following commands (replace `/full/path/to/my/folder` with the previous path noted down)

```bash
echo -e "\n export WORKSPACE=/full/path/to/my/folder \n" >> ~/.bashrc
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install -y g++ cmake make git dos2unix ninja-build
git config --global core.autocrlf input
git clone https://github.com/physycom/sysconfig
sudo apt-get install -y libboost-all-dev libfltk1.3-dev freeglut3-dev libgl1-mesa-dev libglu1-mesa-dev libxinerama-dev libjpeg-dev libxi-dev libxmu-dev
```

3) Open a Bash terminal and type the following command

```bash
cmake --version
```

If the `cmake` installed version is lower than 3.1, it is necessary to manually update it to be able to build the code. Otherwise, your procedure is finished.

4) Open a Bash terminal and type these commands (if you use a 32 bit linux, copy from the second block)

*Linux 64 bit*
```bash
cd $WORKSPACE
export CMAKE_FULL_VERSION="cmake-3.10.0-Linux-x86_64"
export CMAKE_VERSION="v3.10"
mkdir cmake
cd cmake
wget https://cmake.org/files/${CMAKE_VERSION}/${CMAKE_FULL_VERSION}.tar.gz
tar zxvf ${CMAKE_FULL_VERSION}.tar.gz
echo -e "\n export PATH=${WORKSPACE}/cmake/${CMAKE_FULL_VERSION}/bin:\$PATH \n" >> ~/.bashrc
```

*Linux 32 bit*
```bash
cd $WORKSPACE
export CMAKE_FULL_VERSION="cmake-3.6.0-Linux-i386.tar.gz"
export CMAKE_VERSION="v3.6"
mkdir cmake
cd cmake
wget https://cmake.org/files/${CMAKE_VERSION}/${CMAKE_FULL_VERSION}.tar.gz
tar zxvf ${CMAKE_FULL_VERSION}.tar.gz
echo -e "\n export PATH=${WORKSPACE}/cmake/${CMAKE_FULL_VERSION}/bin:\$PATH \n" >> ~/.bashrc
```

## macOS

1) If not already installed, install the XCode Command Line Tools, typing this command in a terminal:

```bash
xcode-select --install
```

2) If not already installed, install Homebrew following the [official guide](https://brew.sh/index_it.html).
3) Open the terminal and type these commands

```bash
brew update
brew upgrade
brew install cmake make git dos2unix ninja
git config --global core.autocrlf input
git clone https://github.com/physycom/sysconfig
brew install fltk boost freeglut
```

4) Define a work folder, which we will call WORKSPACE in this tutorial: this could be a "Code" folder in our home, a "c++" folder on our desktop, whatever you want. Create it if you don't already have, using your favourite method (mkdir in bash, or from the graphical interface in Finder). We will now define an environment variable to tell the system where our folder is. Please note down the full path of this folder, which will look like `/home/$(whoami)/code/`
5) Open a Terminal and type the following command (replace `/full/path/to/my/folder` with the previous path noted down)

```bash
echo -e "\n export WORKSPACE=/full/path/to/my/folder \n" >> ~/.bash_profile
```

## Windows (7+)

1) Install or update Visual Studio to at least version 2017, making sure to have it fully patched (run again the installer if not sure to automatically update to latest version). If you need to install from scratch, download VS from here: [Visual Studio 2017 Community](http://visualstudio.com)
2) If not already installed, please install chocolatey using the [official guide](http://chocolatey.org)
3) If you are not sure about having them updated, or even installed, please install `git`, `cmake` and an updated `Powershell`. To do so, open your Powershell with Administrator privileges and type

```PowerShell
PS \>             cinst -y git cmake powershell ninja
```

4) Restart the PC if required by chocolatey after the latest step
5) Open your Powershell with Administrator privileges, type the following command and confirm it:

```PowerShell
PS \>             Set-ExecutionPolicy unrestricted
```

6) Define a work folder, which we will call WORKSPACE in this tutorial: this could be a "Code" folder in our home, a "cpp" folder on our desktop, whatever you want. Create it if you don't already have, using your favourite method (mkdir in Powershell, or from the graphical interface in explorer). We will now define an environment variable to tell the system where our folder is. Please note down its full path. Open a Powershell (as a standard user) and type

```PowerShell
PS \>             rundll32 sysdm.cpl,EditEnvironmentVariables
```

7) In the upper part of the window that pops-up, we have to create three new environment variables: one with name `WORKSPACE` and value the full path noted down before, one with name `VCPKG_ROOT` and value `%WORKSPACE%\vcpkg` and finally one with name `VCPKG_DEFAULT_TRIPLET` and value `x64-windows-physycom`.
If it not already in the `PATH` (this is possible only if you did it before), we also need to modify the "Path" variable adding the following string (on Windows 10 you need to add a new line to insert it, on Windows Windows 7/8 it is necessary to append it using a `;` as a separator between other records):

```cmd
%PROGRAMFILES%\CMake\bin
```

8) Open a Powershell (as a standard user) and type

```PowerShell
PS \>             cd $env:WORKSPACE
PS Code>          git config --global core.autocrlf input
PS Code>          git clone https://github.com/physycom/sysconfig.git
```

9) If `vcpkg` is not installed, please follow the next procedure, otherwise please jump to #10

```PowerShell
PS \>             cd $env:WORKSPACE
PS Code>          git clone https://github.com/Microsoft/vcpkg.git
PS Code>          cd vcpkg
PS Code>          cp ..\sysconfig\cmake\x64-windows-physycom.cmake .\triplets\
PS Code\vcpkg>    .\bootstrap-vcpkg.bat
```

10) Open a Powershell with Administrator privileges and type

```PowerShell
PS \>             cd $env:WORKSPACE
PS Code>          cd vcpkg
PS Code\vcpkg>    .\vcpkg integrate install
```

11) Open a Powershell (as a standard user) and type (the last command requires a confirmation and is used to clean up unnecessary files)

```PowerShell
PS \>                  cd $env:WORKSPACE
PS Code>               cd vcpkg
PS Code\vcpkg>         .\vcpkg install fltk fltk:x86-windows-static boost boost:x86-windows-static freeglut freeglut:x86-windows-static opengl opengl:x86-windows-static
PS Code\vcpkg>         rmdir .\buildtrees\
PS Code\vcpkg>         cd ([Environment]::GetFolderPath("mydocuments"))
PS \>                  mkdir WindowsPowerShell -Force
PS \>                  cd WindowsPowerShell
PS WindowsPowerShell\> notepad Microsoft.PowerShell_profile.ps1
```

12) In the notepad test editor, press Yes if requested to create a new file and the copy-paste the following commands (append them at the end of the document if it was not empty). Remember to save before exit!

```PowerShell
pushd "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools"
cmd /c "VsDevCmd.bat -arch=x64 & set" |
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
```

### Upgrade software

1) To update software installed with Chocolatey, open a Powershell with Administrator privileges and type

```PowerShell
PS \>             cup all -y
```

2) To update libraries installed with vcpkg, open a Powershell (as a standard user), type these commands and follow on-screen instructions

```PowerShell
PS \>             cd $env:WORKSPACE
PS Code>          cd vcpkg
PS Code>          git pull
PS Code>          .\bootstrap-vcpkg.bat
PS Code>          .\vcpkg update
PS Code>          .\vcpkg upgrade --no-dry-run
```

## Cygwin

1) If not already installed, please install chocolatey using the [official guide](http://chocolatey.org)
2) Open a Powershell with Administrator privileges and type

```PowerShell
PS \>             cinst -y cygwin
```

3) Define a work folder, which we will call WORKSPACE in this tutorial: this could be a "Code" folder in our home, a "cpp" folder on our desktop, whatever you want. Create it if you don't already have, using your favourite method (mkdir in Powershell, or from the graphical interface in explorer). We will now define an environment variable to tell the system where our folder is. Please note down its full path. Open a Powershell (as a standard user) and type

```PowerShell
PS \>             rundll32 sysdm.cpl,EditEnvironmentVariables
```

4) In the upper part of the window that pops-up, create a new variable with name WORKSPACE and value the full path noted down before
5) Open a Powershell (as a standard user) and type (remove the `_x64` suffix in the second line if your operating system is 32 bit)

```PowerShell
PS \>             cd $env:WORKSPACE
PS Code>          Invoke-WebRequest https://cygwin.com/setup-x86_64.exe -OutFile $env:WORKSPACE\cygwin-setup.exe
PS Code>          .\cygwin-setup --quiet-mode --no-shortcuts --no-startmenu --no-desktop --upgrade-also --packages gcc-g++,cmake,git,dos2unix,libboost-devel,libfltk-devel,libglut-devel,libGL-devel,libGLU-devel,fluid,libjpeg-devel,libXi-devel,libXmu-devel
PS Code>          git clone https://github.com/physycom/sysconfig.git
```
