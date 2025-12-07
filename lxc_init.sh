#!/usr/bin/env bash

sed -i 's/# fr_FR.UTF-8/fr_FR.UTF-8/' /etc/locale.gen
echo 'LANG=fr_FR.UTF-8' > /etc/default/locale
locale-gen

useradd -G sudo -m -s /bin/bash user
