#!/bin/bash

export ROS_HOME=/home/sjx/unitree_go2/.ros
export GAZEBO_HOME=/home/sjx/unitree_go2/.gazebo

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=odom_config.sh
source "${SCRIPT_DIR}/odom_config.sh" "$@" || exit 1

cd "${SCRIPT_DIR}"
source install/setup.bash

echo "=== Gazebo ==="
echo "Odometry: ${ODOM_DESC}"
echo "  (edit ODOM_SOURCE in odom_config.sh, or: ODOM_SOURCE=ground_truth $0)"
echo ""

ros2 launch go2_config gazebo_velodyne.launch.py \
  rviz:=true \
  close_loop_odom:=${CLOSE_LOOP_ODOM}
