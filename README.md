## Nvim Lua !!!
Nvim New
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```
Tmux
```
sudo apt install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
chmod +x ~/.tmux/plugins/tpm/tpm
```
Clang
```
sudo apt install clang-format
sudo apt install build-essential clang -y
sudo apt install unzip
```
Clipboard
```
# không cần cũng được
sudo apt install xclip
```
Terminal - .bashrc
```
export PS1='\e[31mTRU\e[0m\e[35mONG\e[0m > ${PWD##*/} '
alias tmux='tmux -f ~/.config/nvim/tmux/tmux.conf'
export PATH=$HOME/.local/bin:$PATH
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
source ~/.bashrc
```
Npm - nodejs
```
sudo apt install npm
sudo apt install nodejs
sudo npm install -g live-server    # web
```
Fish
```
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
Weztem
```
# nên wezterm bên ngoài windows, nên k cần tải lắm
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

Markdown-preview
```
cd ~/.local/share/nvim/lazy/markdown-preview.nvim/app
npm install
```
---------------------------

