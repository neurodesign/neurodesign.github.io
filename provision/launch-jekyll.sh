#!/bin/bash

if [ ! -e pages ]; then
    echo "Creating the pages folder"
    mkdir pages
    echo "Done."
fi

echo "Lauching jekyll"
cd /vagrant && screen -S jekyll -d -m jekyll serve -P 4000 --watch --force_polling
