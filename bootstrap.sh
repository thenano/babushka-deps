#!/bin/sh

type babushka || sh -c "`curl https://babushka.me/up`"
babushka samfoo:$1
