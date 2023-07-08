# Prerequisites for the code building

## Ubuntu On Windows

Required: Windows 10 from version 2004 or Windows 11

1) Open a console using the "Run as administrator" option (right click on it)
2) Type this command

```cmd
wsl --install
```

3) You have now a full ubuntu setup available within Windows, complete with a graphical server (Wayland)
4) Continue in the Ubuntu section

## Ubuntu

1) Define a work folder, which we will call WORKSPACE in this tutorial: this could be a "Code" folder in our home, a "c++" folder on our desktop, whatever you want. Create it if you don't already have, using your favourite method (mkdir in bash, or from the graphical interface of your distribution). We will now define an environment variable to tell the system where our folder is. Please note down the full path of this folder, which will look like `/home/$(whoami)/code/`
2) Open a Bash terminal and type the following commands (replace `/full/path/to/my/folder` with the previous path noted down)

```bash
echo -e "\n export WORKSPACE=/full/path/to/my/folder \n" >> ~/.bashrc
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install -y g++ cmake make git dos2unix ninja-build
git config --global core.autocrlf input
sudo apt-get install -y libgl1-mesa-dev libglu1-mesa-dev libxinerama-dev libxi-dev libxmu-dev
```

3) Open a Bash terminal and type the following command

```bash
cmake --version
```

If the `cmake` installed version is lower than 3.1, it is necessary to manually update it to be able to build the code (follow the procedure [here](https://apt.kitware.com)). Otherwise, your procedure is finished.

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
```

4) Define a work folder, which we will call WORKSPACE in this tutorial: this could be a "Code" folder in our home, a "c++" folder on our desktop, whatever you want. Create it if you don't already have, using your favourite method (mkdir in bash, or from the graphical interface in Finder). We will now define an environment variable to tell the system where our folder is. Please note down the full path of this folder, which will look like `/home/$(whoami)/code/`
5) Open a Terminal and type the following command (replace `/full/path/to/my/folder` with the previous path noted down)

```bash
echo -e "\n export WORKSPACE=/full/path/to/my/folder \n" >> ~/.bash_profile
```

## Windows

1) Install or update Visual Studio to the latest version (currently 2022)
2) Install `git` and `cmake`. To do so, open your Powershell with Administrator privileges and type

```PowerShell
PS \>             winget install -e --id Git.Git
PS \>             winget install -e --id Kitware.CMake
```

3) Open your Powershell with Administrator privileges, type the following command and confirm it:

```PowerShell
PS \>             Set-ExecutionPolicy unrestricted
```

4) Define a work folder, which we will call WORKSPACE in this tutorial: this could be a "Code" folder in our home, a "cpp" folder on our desktop, whatever you want. Create it if you don't already have, using your favourite method (mkdir in Powershell, or from the graphical interface in explorer). We will now define an environment variable to tell the system where our folder is. Please note down its full path. Open a Powershell (as a standard user) and type

```PowerShell
PS \>             rundll32 sysdm.cpl,EditEnvironmentVariables
```

5) In the upper part of the window that pops-up, we have to create a new environment variable, with name `WORKSPACE` and value the full path noted down before

6) Open a Powershell (as a standard user) and type

```PowerShell
PS \>             cd $env:WORKSPACE
PS Code>          git config --global core.autocrlf input
```
