#!/bin/bash

# This both puts the sources in the right place and gives us $VERSION
source linbuild.sh

# Set up a directory structure for the debian build
cd dist
mkdir debian
cp src/kancolletool-${VERSION}.tar.gz debian/kancolletool_${VERSION}.orig.tar.gz
cp src/kancolletool-viewer-${VERSION}.tar.gz debian/kancolletool-viewer_${VERSION}.orig.tar.gz

cd debian
tar -xf kancolletool_${VERSION}.orig.tar.gz
tar -xf kancolletool-viewer_${VERSION}.orig.tar.gz

# Debianize and package the Tool
# Note that we're not signing these packages, simply because signing raises
# annoying errors on every machines except the one my keys are on
cd kancolletool-${VERSION}/
cp -R ../../../targets/debian/kancolletool/debian .
hash debuild >/dev/null 2>&1 && debuild -us -uc || dpkg-buildpackage
cd ..

# Debianize and package the Viewer
# See above about the explicit lack of signing
cd kancolletool-viewer-${VERSION}/
cp -R ../../../targets/debian/kancolletool-viewer/debian .
hash debuild >/dev/null 2>&1 && debuild -us -uc || dpkg-buildpackage
cd ..

# Go back to the root folder
cd ..
