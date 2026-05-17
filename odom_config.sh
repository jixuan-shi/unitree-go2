#!/bin/bash

ODOM_SOURCE="${ODOM_SOURCE:-ground_truth}"

case "$ODOM_SOURCE" in
    ground_truth)
        ODOM_DESC="Ground Truth (Gazebo)"
        CLOSE_LOOP_ODOM="true"
        ;;
    leg_odometry)
        ODOM_DESC="Leg Odometry"
        CLOSE_LOOP_ODOM="false"
        ;;
    *)
        echo "Unknown ODOM_SOURCE: $ODOM_SOURCE"
        echo "Valid options: ground_truth, leg_odometry"
        exit 1
        ;;
esac

if [ $# -gt 0 ]; then
    for arg in "$@"; do
        case "$arg" in
            close_loop_odom=*)
                CLOSE_LOOP_ODOM="${arg#*=}"
                ;;
        esac
    done
fi
