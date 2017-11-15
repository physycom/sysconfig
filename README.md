# Prerequisiti per la compilazione del codice

## Ubuntu On Windows

Si suggerisce di utilizzare Bash on Ubuntu on Windows solo a partire dalla build 15063 (Creators Update).
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
sudo apt-get install g++ cmake make git 
git config --global core.autocrlf input
sudo apt-get install libboost-all-dev libfltk1.3-dev freeglut3-dev libgl1-mesa-dev libglu1-mesa-dev libxinerama-dev libjpeg-dev libxi-dev libxmu-dev
```

Rispondere Y (oppure S) alle eventuali richieste di conferma

## macOS

1) Installare gli XCode Command Line Tools, se non già installati, digitando su un terminale il seguente comando:

```bash
xcode-select --install
```

2) Se non ancora installato, installare Homebrew secondo la guida presente sulla [homepage](https://brew.sh/index_it.html).
3) Aprire un terminale e digitare

```bash
brew update
brew upgrade
brew install cmake make git
git config --global core.autocrlf input
brew install fltk boost freeglut
```

4) Definire una cartella di lavoro, che chiameremo WORKSPACE d'ora in poi: questa sarà una cartella "Codice" nella nostra home, oppure una cartella "code" sul desktop, tutto a vostro piacimento. Createla, se non ce l'avete già, nel modo preferito (mkdir da terminale, oppure direttamente dall'interfaccia grafica del Finder col mouse). Standardizzeremo il funzionamento dei nostri script indipendentemente dalla posizione di questa cartella definendo a tal proposito una variabile d'ambiente. Attenzione a sapere esattamente il path assoluto di questa cartella, che assomiglierà ad una cosa del tipo `/Users/$(whoami)/codice/`
5) Aprire quindi un terminale nuovo e digitare (sostituire `/path/completo/alla/nostra/cartella` con il path che abbiamo appena stabilito)

```bash
echo -e "\n export WORKSPACE=/path/completo/alla/nostra/cartella \n" >> ~/.bash_profile
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install g++ cmake make git 
git config --global core.autocrlf input
sudo apt-get install libboost-all-dev libfltk1.3-dev freeglut3-dev libgl1-mesa-dev libglu1-mesa-dev libxinerama-dev libjpeg-dev libxi-dev libxmu-dev
```


## Windows (7+)

1) Installare/aggiornare Visual Studio alla versione 2017, assicurandosi di avere le ultime patch (lanciare l'installer per sicurezza per aggiornare automaticamente all'ultima versione). Se è necessario installarlo da zero, scaricarlo da qui: [Visual Studio 2017 Community](http://visualstudio.com).
2) Se non installato, installare [chocolatey](http://chocolatey.org) seguendo le istruzioni sul sito
3) Se non avete `git` e `cmake` già installati, oppure se non siete sicuri di avere una Powershell recente, aprire Powershell in modalità amministratore e quindi digitare

```PowerShell
PS \>             cinst -y git cmake powershell
```

4) Riavviare il PC se richiesto da chocolatey
5) Definire una cartella di lavoro, che chiameremo WORKSPACE d'ora in poi: una cartella "Codice" nella nostra home, oppure una cartella "code" sul desktop, creandola nel modo preferito (mkdir da Powershell, oppure direttamente da explorer col mouse). Standardizzeremo il funzionamento dei nostri script indipendentemente dalla posizione di questa cartella definendo a tal proposito una variabile d'ambiente. Aprire pertanto una Powershell in modalità utente standard e digitare

```PowerShell
PS \>             rundll32 sysdm.cpl,EditEnvironmentVariables
```

6) Nella schermata che si apre, nella sezione superiore, creare una nuova variabile con nome WORKSPACE e come valore il path completo della nostra cartella di lavoro precedentemente stabilita. Se CMake non fosse già nel path perché già fatto in passato, bisogna inoltre aggiungere alla variabile "Path" il seguente percorso (su Windows 10 è sufficiente creare una nuova riga, su Windows 7/8 invece è necessario assicurarsi di separare con un `;` l'aggiunta da eventuali altri record presenti):

```cmd
%PROGRAMFILES%/CMake/bin
```

7) Aprire una nuova Powershell, come utente standard, e clonare questo repository seguendo le istruzioni seguenti

```PowerShell
PS \>             cd $env:WORKSPACE
PS Codice>        git config --global core.autocrlf input
PS Codice>        git clone https://github.com/physycom/sysconfig.git
```

8) Se vcpkg non è installato, eseguire la procedura seguente, altrimenti saltare direttamente al punto 10.

```PowerShell
PS \>             cd $env:WORKSPACE
PS Codice>        git clone https://github.com/Microsoft/vcpkg.git
PS Codice>        cd vcpkg
PS Codice\vcpkg>  .\bootstrap-vcpkg.bat
```

9) Aprire Powershell in modalità amministratore e quindi digitare

```PowerShell
PS \>             cd $env:WORKSPACE
PS Codice>        cd vcpkg
PS Codice\vcpkg>  .\vcpkg integrate install
```

10) Aprire Powershell in modalità utente standard e quindi digitare

```PowerShell
PS \>             cd $env:WORKSPACE
PS Codice>        cd vcpkg
PS Codice\vcpkg>  .\vcpkg install fltk fltk:x86-windows-static boost boost:x86-windows-static freeglut freeglut:x86-windows-static opengl opengl:x86-windows-static
```

11) Aprire un editor di testo qualsiasi (anche notepad.exe va bene!) e incollare il seguente testo:

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
```

e salvarlo nella cartella `Documenti\WindowsPowerShell` del proprio utente con nome `Microsoft.PowerShell_profile.ps1`

### Upgrade software

1) Per aggiornare i programmi installati con Chocolatey, aprire una Powershell in modalità amministratore e quindi digitare

```PowerShell
PS \>             cup all -y
```

2) Per aggiornare le librerie installate con vcpkg, aprire una Powershell come utente standard e quindi digitare

```PowerShell
PS \>             cd $env:WORKSPACE
PS Codice>        cd vcpkg
PS Codice>        git pull
PS Codice>        .\vcpkg update
```

e quindi seguire le istruzioni a video
