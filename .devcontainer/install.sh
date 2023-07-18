#!/bin/bash
echo "Updating submodule ..."
git submodule update --init --recursive
echo "Compiling the project ..."
make
