# Minimal SLAM launch for Gazebo simulation (no Nav2 stack).

import os
from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument, IncludeLaunchDescription
from launch.substitutions import LaunchConfiguration, PathJoinSubstitution
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch_ros.substitutions import FindPackageShare


def generate_launch_description():
    this_package = FindPackageShare('go2_config')

    default_params_file_path = PathJoinSubstitution(
        [this_package, 'config/autonomy', 'slam.yaml']
    )

    slam_launch_path = PathJoinSubstitution(
        [FindPackageShare('slam_toolbox'), 'launch', 'online_async_launch.py']
    )

    return LaunchDescription([
        DeclareLaunchArgument(
            name='slam_params_file',
            default_value=default_params_file_path,
            description='slam_toolbox parameter file',
        ),
        DeclareLaunchArgument(
            name='use_sim_time',
            default_value='true',
            description='Use Gazebo simulation clock',
        ),
        IncludeLaunchDescription(
            PythonLaunchDescriptionSource(slam_launch_path),
            launch_arguments={
                'use_sim_time': LaunchConfiguration('use_sim_time'),
                'slam_params_file': LaunchConfiguration('slam_params_file'),
            }.items(),
        ),
    ])
