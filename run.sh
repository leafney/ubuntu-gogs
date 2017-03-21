#!/bin/bash
set -x

export USER=git
exec gosu $USER /home/git/gogs/gogs web