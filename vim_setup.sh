# Update and upgrade
sudo apt-get update
sudo apt-get upgrade -y

# Copy over vimfiles
mkdir ~/.vim
cp colors.vim ~/.vim/
cp filetypes.vim ~/.vim/
cp extended.vim ~/.vim/
cp .vimrc ~/

# Get Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Setup YouCompleteMe
sudo apt install build-essential cmake3 python3-dev
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --clang-completer
python3 install.py --all
