#!/bin/bash
set -ex

CLIONFILE=CLion.tar.gz
if [[ -f /mnt/${CLIONFILE} ]]; then
  tar xvf /mnt/${CLIONFILE} -C /root
else
  curl --output /root/${CLIONFILE} https://download-cdn.jetbrains.com/cpp/CLion-2021.2.tar.gz
  tar xvf /root/${CLIONFILE} -C /root
fi

ln -s /root/clion*/bin/clion.sh /root/Desktop/start-clion.sh
