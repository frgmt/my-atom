#!/bin/bash

atom_path="/Users/$USER/.atom"

timestamp() {
    date +"%s"
}

backup() {
    currtime="$(timestamp)"
    mkdir -pv $atom_path/backup
    mkdir -pv $atom_path/backup/$currtime/packages
    mkdir -pv $atom_path/backup/$currtime/configs
    cp -fr $atom_path/packages $atom_path/backup/$currtime/packages
    cp -f $atom_path/{init.coffee,config.cson,projects.cson,snippets.cson,styles.less,toolbar.cson} $atom_path/backup/$currtime/configs
}

fetch() {
    rm -f package.list
    apm list --installed --bare > my-packages.list && echo "Packages list created."
    cp -f $atom_path/{init.coffee,config.cson,projects.cson,snippets.cson,styles.less,toolbar.cson} ./config && echo "Configuration files copied."
}

install() {
    apm install --package-file ./my-packages.list
    cp -f ./config/{init.coffee,config.cson,projects.cson,snippets.cson,styles.less,toolbar.cson} $atom_path
}

case "$1" in
    backup) backup
        ;;
    fetch) fetch
        ;;
    install) backup && install
        ;;
    *) echo -e "\tbackup -- Backups your current configuration\n\tfetch -- Saves configuration and packages information\n\tinstall -- Copies and installs packages and configuration files"
        ;;
esac 
