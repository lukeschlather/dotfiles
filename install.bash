#!/bin/bash

cd
for file in `ls -A ~/dotfiles/primary/`
do
    echo "installing ${file}"
    # make a backup if the file/directory already exists
    if [[ ! -h ~/${file} ]] ; then
	if [[ -f ~/${file} ]] || [[ -d ~/${file} ]] ; then
	    echo cp -r ~/${file} ~/${file}.`date +'%Y%d%m'`
	    cp -r ~/${file} ~/${file}.`date +'%Y%d%m'`
	fi
    fi
    rm ~/${file}
    ln -s ~/dotfiles/primary/${file} ~/${file}
done

exit
