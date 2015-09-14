#!/bin/sh

sudo mkdir -p /usr/local/babushka
sudo chown -R `whoami` /usr/local/babushka
sudo mkdir -p /usr/local/bin
sudo chown -R `whoami` /usr/local/bin

type babushka || sh -c "`curl https://babushka.me/up`"
babushka thenano:$1
