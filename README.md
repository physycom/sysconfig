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
5) aprire la Bash ed abilitarne il funzionamento con VcXsrv con la seguente procedura (va fatta solo la prima volta)

```bash
sudo apt-get install vim
cd
vim .bashrc
# spostarsi alla fine del file, quindi premere il tasto I sulla tastiera
# scrivere la seguente linea di codice
export DISPLAY=localhost:0.0
# uscire e salvare premendo in sequenza questi tasti (i 'due punti' non sono estetici, fanno parte della sequenza, mentre invece ESC ed ENTER sono i rispettivi tasti della tastiera!)
# ESC : w q ENTER
```

6) Seguire infine la guida per Ubuntu

## Ubuntu

Aprire un terminale bash e digitare

```bash
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
3) Aprire infine un terminale e digitare

```bash
brew update
brew upgrade
brew install cmake make git
git config --global core.autocrlf input
brew install fltk boost freeglut
```

## Windows (7+)

1) Installare/aggiornare Visual Studio alla versione 2017. Se è necessario installarlo, scaricarlo da qui: [Visual Studio 2017 Community](http://visualstudio.com).
2) Se non installato, installare [chocolatey](http://chocolatey.org)
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

7) Se vcpkg non è installato, eseguire la procedura seguente, altrimenti saltare direttamente al punto 9. Chiudere la Powershell e riaprirla, sempre in modalità utente standard

```PowerShell
PS \>             cd $env:WORKSPACE
PS Codice>        git config --global core.autocrlf input
PS Codice>        git clone https://github.com/Microsoft/vcpkg.git
PS Codice>        cd vcpkg
PS Codice\vcpkg>  .\bootstrap-vcpkg.bat
```

8) Aprire Powershell in modalità amministratore e quindi digitare

```PowerShell
PS \>             cd $env:WORKSPACE
PS Codice>        cd vcpkg
PS Codice\vcpkg>  .\vcpkg integrate install
```

9) Aprire Powershell in modalità utente standard e quindi digitare

```PowerShell
PS \>             cd $env:WORKSPACE
PS Codice>        cd vcpkg
PS Codice\vcpkg>  .\vcpkg install fltk fltk:x86-windows-static boost boost:x86-windows-static freeglut freeglut:x86-windows-static opengl opengl:x86-windows-static
```

10) Aprire un editor di testo qualsiasi (anche notepad.exe va bene!) e incollare il seguente testo:

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

1) Per aggiornare i programmi installati con Chocolatey, aprire Powershell in modalità amministratore e quindi digitare

```PowerShell
PS \>             cup all -y
```

