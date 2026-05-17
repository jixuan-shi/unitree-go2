#!/bin/bash

export ROS_HOME=/home/sjx/unitree_go2/.ros
export GAZEBO_HOME=/home/sjx/unitree_go2/.gazebo

cd /home/sjx/unitree_go2
source install/setup.bash

# Run after Gazebo is up (./launch_gazebo.sh or ./start_slam.sh)
ros2 launch go2_config slam_only.launch.py use_sim_time:=true
