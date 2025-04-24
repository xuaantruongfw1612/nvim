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
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
echo 'export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/truong/.local/share/flatpak/exports/share' >> ~/.bashrc
echo "alias wezterm='flatpak run org.wezfurlong.wezterm'" >> ~/.bashrc
source ~/.bashrc
```
Tmux
```c
sudo apt install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
chmod +x ~/.tmux/plugins/tpm/tpm
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
export PS1='\e[31mTRU\e[0m\e[35mONG\e[0m > ${PWD##*/} '
alias tmux='tmux -f ~/.config/nvim/tmux/tmux.conf'
export PATH=$HOME/.local/bin:$PATH
```
Fish
```c
sudo apt install fish
nvim .config/fish/functions/fish_prompt.fish
# In fish_prompt.fish
function fish_prompt
    set_color red
    echo -n (whoami)
    set_color normal
    echo -n " >"
set -g fish_color_error red --bold
set -g fish_color_command white --bold
echo -n " "(basename (pwd))" "
end
```
