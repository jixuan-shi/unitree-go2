#!/bin/bash

echo "Cleaning up Gazebo and ROS2 processes..."

killall -9 gzserver 2>/dev/null
killall -9 gzclient 2>/dev/null
killall -9 gazebo 2>/dev/null
killall -9 rviz2 2>/dev/null

sleep 1

rm -rf /tmp/gazebo* 2>/dev/null
rm -rf ~/.gazebo/server-* 2>/dev/null
rm -rf /home/sjx/unitree_go2/.gazebo/server-* 2>/dev/null

echo "Cleanup complete!"
