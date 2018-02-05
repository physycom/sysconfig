# Prerequisiti per la compilazione del codice

## Ubuntu On Windows

Si suggerisce di utilizzare Bash on Ubuntu on Windows solo a partire dalla build 15063 (Creators Update)
1) Se non è già installato nel sistema, installare [chocolatey](http://chocolatey.org)
2) Se nel sistema Windows non è già presente un server X, installarlo con questa procedura: aprire Powershell in modalità amministratore e quindi digitare

```PowerShell
PS \>  cinst -y vcxsrv
```

3) lanciare VcXsrv (è necessario che sia aperto ogni volta che si lanciano processi grafici dentro la bash!)
4) Se non ancora abilitato, attivare UoW seguendo la [guida ufficiale](https://msdn.microsoft.com/it-it/commandline/wsl/install_guide)
5) aprire la Bash ed abilitarne il funzionamento con VcXsrv con il seguente comando

```bash
echo -e "\n export DISPLAY=localhost:0.0 \n" >> ~/.bashrc
```

6) Seguire infine la guida per Ubuntu

## Ubuntu

1) Definire una cartella di lavoro, che chiameremo WORKSPACE d'ora in poi: questa sarà una cartella "Codice" nella nostra home, oppure una cartella "code" sul desktop, tutto a vostro piacimento. Createla, se non ce l'avete già, nel modo preferito (mkdir da bash, oppure direttamente dall'interfaccia grafica col mouse). Standardizzeremo il funzionamento dei nostri script indipendentemente dalla posizione di questa cartella definendo a tal proposito una variabile d'ambiente. Attenzione a sapere esattamente il path assoluto di questa cartella, che assomiglierà ad una cosa del tipo `/home/$(whoami)/codice/`
2) Aprire quindi un terminale bash e digitare (sostituire `/path/completo/alla/nostra/cartella` con il path che abbiamo appena stabilito)

```bash
echo -e "\n export WORKSPACE=/path/completo/alla/nostra/cartella \n" >> ~/.bashrc
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install -y g++ cmake make git dos2unix ninja-build
git config --global core.autocrlf input
git clone https://github.com/physycom/sysconfig
sudo apt-get install -y libboost-all-dev libfltk1.3-dev freeglut3-dev libgl1-mesa-dev libglu1-mesa-dev libxinerama-dev libjpeg-dev libxi-dev libxmu-dev
```

3) Aprire un terminale bash e digitare il seguente comando

```bash
cmake --version
```

Se la versione di `cmake` installata è precedente alla 3.1, è necessario procedere con gli step seguenti per aggiornare manualmente il software. Altrimenti la procedura è conclusa.

4) Aprire un terminale bash e digitare i seguenti comandi (nb: nel caso si utilizzi un linux a 32 bit utilizzare il secondo blocco)

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

1) Installare gli XCode Command Line Tools, se non già installati, digitando su un terminale il seguente comando:

```bash
xcode-select --install
```

2) Se non ancora installato, installare Homebrew secondo la guida presente sulla [homepage](https://brew.sh/index_it.html)
3) Aprire un terminale e digitare

```bash
brew update
brew upgrade
brew install cmake make git dos2unix ninja
git config --global core.autocrlf input
git clone https://github.com/physycom/sysconfig
brew install fltk boost freeglut
```

4) Definire una cartella di lavoro, che chiameremo WORKSPACE d'ora in poi: questa sarà una cartella "Codice" nella nostra home, oppure una cartella "code" sul desktop, tutto a vostro piacimento. Createla, se non ce l'avete già, nel modo preferito (mkdir da terminale, oppure direttamente dall'interfaccia grafica del Finder col mouse). Standardizzeremo il funzionamento dei nostri script indipendentemente dalla posizione di questa cartella definendo a tal proposito una variabile d'ambiente. Attenzione a sapere esattamente il path assoluto di questa cartella, che assomiglierà ad una cosa del tipo `/Users/$(whoami)/codice/`
5) Aprire quindi un terminale nuovo e digitare (sostituire `/path/completo/alla/nostra/cartella` con il path che abbiamo appena stabilito)

```bash
echo -e "\n export WORKSPACE=/path/completo/alla/nostra/cartella \n" >> ~/.bash_profile
```

## Windows (7+)

1) Installare/aggiornare Visual Studio alla versione 2017, assicurandosi di avere le ultime patch (lanciare l'installer per sicurezza per aggiornare automaticamente all'ultima versione). Se è necessario installarlo da zero, scaricarlo da qui: [Visual Studio 2017 Community](http://visualstudio.com)
2) Se non installato, installare [chocolatey](http://chocolatey.org) seguendo le istruzioni sul sito
3) Se non avete `git` e `cmake` già installati, oppure se non siete sicuri di avere una Powershell recente, aprire Powershell in modalità amministratore e quindi digitare

```PowerShell
PS \>             cinst -y git cmake powershell ninja
```

4) Riavviare il PC se richiesto da chocolatey
5) Avviare Powershell in modalità ammministratore e digitare il seguente comando (dare inoltre conferma al messaggio che compare)

```PowerShell
PS \>             Set-ExecutionPolicy unrestricted
```

6) Definire una cartella di lavoro, che chiameremo WORKSPACE d'ora in poi: una cartella "Codice" nella nostra home, oppure una cartella "code" sul desktop, creandola nel modo preferito (mkdir da Powershell, oppure direttamente da explorer col mouse). Standardizzeremo il funzionamento dei nostri script indipendentemente dalla posizione di questa cartella definendo a tal proposito una variabile d'ambiente. Aprire pertanto una Powershell in modalità utente standard e digitare

```PowerShell
PS \>             rundll32 sysdm.cpl,EditEnvironmentVariables
```

7) Nella schermata che si apre, nella sezione superiore, dobbiamo creare tre nuove variabili: una con nome `WORKSPACE` e come valore il path completo della nostra cartella di lavoro precedentemente stabilita, una con nome `VCPKG_ROOT` e valore `%WORKSPACE%\vcpkg` ed infine l'ultima con nome `VCPKG_DEFAULT_TRIPLET` e valore `x64-windows-physycom`.
Se CMake non fosse già nel `PATH` perché già fatto in passato, bisogna inoltre aggiungere alla variabile "Path" (diversa dalle precedenti, questa dovrebbe esistere già) il seguente percorso (su Windows 10 è sufficiente creare una nuova riga, su Windows 7/8 invece è necessario assicurarsi di separare con un `;` l'aggiunta da eventuali altri record presenti):

```cmd
%PROGRAMFILES%\CMake\bin
```

8) Aprire una nuova Powershell, come utente standard, e clonare questo repository seguendo le istruzioni seguenti

```PowerShell
PS \>             cd $env:WORKSPACE
PS Codice>        git config --global core.autocrlf input
PS Codice>        git clone https://github.com/physycom/sysconfig.git
```

9) Se `vcpkg` non è installato, eseguire la procedura seguente, altrimenti saltare direttamente al punto 10

```PowerShell
PS \>             cd $env:WORKSPACE
PS Codice>        git clone https://github.com/Microsoft/vcpkg.git
PS Codice>        cd vcpkg
PS Codice>        cp ..\sysconfig\cmake\x64-windows-physycom.cmake .\triplets\
PS Codice\vcpkg>  .\bootstrap-vcpkg.bat
```

10) Aprire Powershell in modalità amministratore e quindi digitare

```PowerShell
PS \>             cd $env:WORKSPACE
PS Codice>        cd vcpkg
PS Codice\vcpkg>  .\vcpkg integrate install
```

11) Aprire Powershell in modalità utente standard e quindi digitare (l'ultimo comando richiede una conferma e serve per rimuovere files non necessari)

```PowerShell
PS \>                  cd $env:WORKSPACE
PS Codice>             cd vcpkg
PS Codice\vcpkg>       .\vcpkg install fltk boost freeglut opengl
PS Codice\vcpkg>       rmdir .\buildtrees\
PS Codice\vcpkg>       cd ([Environment]::GetFolderPath("mydocuments"))
PS \>                  mkdir WindowsPowerShell -Force
PS \>                  cd WindowsPowerShell
PS WindowsPowerShell\> notepad Microsoft.PowerShell_profile.ps1
```

12) Nel caso sia comparsa una finestra che chiede conferma per creare il file, rispondere di sì. Dopo di che copiare i seguenti comandi nel documento che si è aperto (nel caso non fosse vuoto mettere questi comandi in fondo) e salvare il file:

```PowerShell
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

1) Per aggiornare i programmi installati con Chocolatey, aprire una Powershell in modalità amministratore e quindi digitare

```PowerShell
PS \>             cup all -y
```

2) Per aggiornare le librerie installate con vcpkg, aprire una Powershell come utente standard, digitare i seguenti comandi e quindi seguire le istruzioni a video

```PowerShell
PS \>             cd $env:WORKSPACE
PS Codice>        cd vcpkg
PS Codice>        git pull
PS Codice>        .\bootstrap-vcpkg.bat
PS Codice>        .\vcpkg update
PS Codice>        .\vcpkg upgrade --no-dry-run
```

## Cygwin

1) Se non è già installato nel sistema, installare [chocolatey](http://chocolatey.org)
2) Aprire Powershell in modalità amministratore e quindi digitare

```PowerShell
PS \>             cinst -y cygwin
```

3) Definire una cartella di lavoro, che chiameremo WORKSPACE d'ora in poi: una cartella "Codice" nella nostra home, oppure una cartella "code" sul desktop, creandola nel modo preferito (mkdir da Powershell, oppure direttamente da explorer col mouse). Standardizzeremo il funzionamento dei nostri script indipendentemente dalla posizione di questa cartella definendo a tal proposito una variabile d'ambiente. Aprire pertanto una Powershell in modalità utente standard e digitare

```PowerShell
PS \>             rundll32 sysdm.cpl,EditEnvironmentVariables
```

4) Nella schermata che si apre, nella sezione superiore, creare una nuova variabile con nome WORKSPACE e come valore il path completo della nostra cartella di lavoro precedentemente stabilita
5) Aprire una nuova Powershell in modalità utente standard e quindi digitare (rimuovere il suffisso `_x64` nella seconda riga se il proprio sistema operativo è a 32 bit)

```PowerShell
PS \>             cd $env:WORKSPACE
PS Codice>        Invoke-WebRequest https://cygwin.com/setup-x86_64.exe -OutFile $env:WORKSPACE\cygwin-setup.exe
PS Codice>        .\cygwin-setup --quiet-mode --no-shortcuts --no-startmenu --no-desktop --upgrade-also --packages gcc-g++,cmake,git,dos2unix,libboost-devel,libfltk-devel,libglut-devel,libGL-devel,libGLU-devel,fluid,libjpeg-devel,libXi-devel,libXmu-devel
PS Codice>        git clone https://github.com/physycom/sysconfig
```
