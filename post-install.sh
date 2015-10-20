#!/bin/bash
#
# Post-install operations which haven't been moved into chef yet:

set -e
set -x

if [ ! -d ~/.pow ]; then
  curl get.pow.cx | sh
fi

vim +BundleInstall +qall

apm install linter-rubocop
