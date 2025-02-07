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
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```
```c
echo 'export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/truong/.local/share/flatpak/exports/share' >> ~/.bashrc
source ~/.bashrc

```
```c
flatpak install flathub org.wezfurlong.wezterm
flatpak run org.wezfurlong.wezterm
```
```c
echo "alias wezterm='flatpak run org.wezfurlong.wezterm'" >> ~/.bashrc
source ~/.bashrc
```
