#!/bin/bash
echo "Updating submodule ..."
git submodule update --init --recursive

echo "Installing dependencies ..."
pip install rospkg
sudo apt update
sudo apt install -y python-is-python3

sudo rm -rf /etc/ros/rosdep/sources.list.d/20-default.list 
sudo rosdep init
rosdep update

echo "Compiling the project ..."
source /opt/ros/noetic/setup.bash
export ROS_PACKAGE_PATH=$(pwd):$ROS_PACKAGE_PATH
make
