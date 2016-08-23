#!/bin/bash
# This script runs the normal tests

python_v=${1:-}

tox -e "$(echo py"${python_v}" | tr -d . | sed -e 's/pypypy/pypy/')"
