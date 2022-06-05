#!/bin/env bash

add_or_replace () {

    # Skip if this is already a symlink.
    if [ -h "$1" ]; then
	echo "[INFO] skipping $1 : already a symlink."
	return
    fi
        
    # Remove file if it already exists.
    if [ -f "$1" ]; then
	echo "[INFO] removing file $1."
	rm -I "$1"
    fi

    # Remove directory if it already exists.
    if [ -d "$1" ]; then
	echo "[INFO] removing directory $1."
	rm -Idr "$1"
    fi    
    
    # Create symlink.
    echo "[INFO] creating sym. link $1 -> $2."
    ln -s "$2" "$1"
}

# Ensure we're in the home folder.
cd ~ || exit       

# Bash
add_or_replace '.bashrc'       '.config/bash/rc'
add_or_replace '.bash_profile' '.config/bash/profile'
add_or_replace '.bash_logout'  '.config/bash/logout'
add_or_replace '.bash_aliases' '.config/bash/aliases'
add_or_replace '.env'          '.config/bash/environment'

# X11
add_or_replace '.Xresources'   '.config/X11/resources'

# Editors
add_or_replace '.emacs.d'      '.config/emacs/'
add_or_replace '.vimrc'        '.config/vim/rc'

# Other
add_or_replace '.ssh'          '.config/ssh/'
add_or_replace '.gitconfig'    '.config/git/config'
add_or_replace '.gtkrc-2.0'    '.config/gtk-2.0/settings.ini'
add_or_replace '.gnatstudio'   '.config/gnatstudio'
add_or_replace '.icons'        '.config/icons/'

