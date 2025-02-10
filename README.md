## Nvim Lua !!!
Nvim New
```c
snap version
sudo apt update
sudo apt install snapd
sudo systemctl enable --now snapd
sudo snap install nvim --classic
```
Weztem
```c
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak install flathub org.wezfurlong.wezterm
flatpak run org.wezfurlong.wezterm
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
echo 'export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/truong/.local/share/flatpak/exports/share' >> ~/.bashrc
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
echo "alias wezterm='flatpak run org.wezfurlong.wezterm'" >> ~/.bashrc
source ~/.bashrc
```
Tmux
```c
sudo apt install tmux
```
Clang
```c
sudo apt install build-essential clang -y
```
Clipboard
```c
sudo apt install xclip
```
Terminal - .bashrc
```c
export PS1='\[\033[01;31m\]\u\[\033[00m\] \[\033[01;35m\][\A]\[\033[00m\] > \[\033[01;97m\]\w\[\033[00m\] '
```
Fish
```c
sudo apt install fish
```
