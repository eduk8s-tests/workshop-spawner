#!/bin/bash

export PYTHONUNBUFFERED=1
export PYTHONIOENCODING=UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PIP_NO_CACHE_DIR=off

source /opt/spawner/venv/bin/activate

exec python `dirname $0`/cull-idle-servers.py "$@"
