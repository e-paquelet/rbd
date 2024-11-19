#!/bin/bash

wget https://img.freepik.com/photos-premium/paysage-fantastique-lac-montagnes-nuit-generative-ai-i_841229-8453.jpg -O $HOME/img.jpg

gsettings set org.mate.background picture-filename $HOME/img.jpg