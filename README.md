## Nvim Lua !!!
Nvim New
```c
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```
Tmux
```c
sudo apt install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
chmod +x ~/.tmux/plugins/tpm/tpm
```
Clang
```c
sudo apt install clang-format
sudo apt install build-essential clang -y
sudo apt install unzip
```
Clipboard
```c
# không cần cũng được
sudo apt install xclip
```
Terminal - .bashrc
```c
export PS1='\e[31mTRU\e[0m\e[35mONG\e[0m > ${PWD##*/} '
alias tmux='tmux -f ~/.config/nvim/tmux/tmux.conf'
export PATH=$HOME/.local/bin:$PATH
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
source ~/.bashrc
```
Npm - nodejs
```c
sudo apt install npm
sudo apt install nodejs
sudo npm install -g live-server    # web
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
Weztem
```c
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
```c
cd ~/.local/share/nvim/lazy/markdown-preview.nvim/app
npm install
```
---------------------------
Linux
# Cập nhật hệ thống + cài curl
sudo apt update
sudo apt install -y curl build-essential libfuse2

# Cài Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Thêm Homebrew vào PATH
echo >> ~/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Cài WezTerm qua Homebrew (sẽ tải AppImage)
brew tap wez/wezterm-linuxbrew
brew install wezterm

# Cho AppImage quyền chạy
chmod +x ~/.cache/Homebrew/downloads/*WezTerm-*.AppImage

# Tạo symlink để gọi "wezterm" ở mọi nơi
sudo ln -sf ~/.cache/Homebrew/downloads/*WezTerm-*.AppImage /usr/local/bin/wezterm

# Chạy thử
wezterm
