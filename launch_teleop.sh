#!/bin/bash

export ROS_HOME=/home/sjx/unitree_go2/.ros

cd /home/sjx/unitree_go2
source install/setup.bash

ros2 run teleop_twist_keyboard teleop_twist_keyboard
