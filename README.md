# Unitree Go2 ROS2 配置包

## 功能展示

| 功能 | 状态 | 说明 |
|------|------|------|
| Gazebo 仿真 | ✅ | 在 Gazebo 中运行机器人仿真 |
| RViz 可视化 | ✅ | 实时显示机器人模型和传感器数据 |
| 键盘遥控 | ✅ | 使用键盘控制机器人运动 |
| 2D 激光雷达 | ✅ | Hokuyo 2D LiDAR 支持 |
| 3D 激光雷达 | ✅ | Velodyne 3D LiDAR 支持 |
| SLAM 建图 | ✅ | 使用 slam_toolbox 进行 2D 建图 |
| Navigation 导航 | ❌ | 待实现 |

## 环境要求

- Ubuntu 22.04
- ROS 2 Humble

## 安装依赖

```bash
sudo apt install ros-humble-gazebo-ros2-control
sudo apt install ros-humble-xacro
sudo apt install ros-humble-robot-localization
sudo apt install ros-humble-ros2-controllers
sudo apt install ros-humble-ros2-control
sudo apt install ros-humble-velodyne
sudo apt install ros-humble-velodyne-gazebo-plugins
sudo apt-get install ros-humble-velodyne-description
sudo apt install -y python3-rosdep
rosdep update
```

## 构建工作空间

```bash
cd <your_ws>
colcon build
source install/setup.bash
```

## 快速开始

### Gazebo 仿真

启动 Gazebo 环境：

```bash
ros2 launch go2_config gazebo.launch.py
```

启动 Gazebo + RViz：

```bash
ros2 launch go2_config gazebo.launch.py rviz:=true
```

### 键盘遥控

```bash
ros2 run teleop_twist_keyboard teleop_twist_keyboard
```

### 2D 激光雷达配置

> 默认使用 2D Hokuyo 激光雷达

```bash
ros2 launch go2_config gazebo.launch.py rviz:=true
```

如需切换激光雷达类型，编辑 `robots/descriptions/go2_description/xacro/robot_VLP.xacro`：

```xml
<!-- 使用 2D Hokuyo -->
<xacro:include filename="$(find go2_description)/xacro/laser.xacro"/>

<!-- 使用 3D Velodyne -->
<!-- <xacro:include filename="$(find go2_description)/xacro/velodyne.xacro"/> -->
```

### 3D 激光雷达配置

```bash
ros2 launch go2_config gazebo_velodyne.launch.py rviz:=true
```

> 注意：在 RViz 中将 PointCloud2 话题设置为 `/velodyne_points`

## SLAM 建图

### 启动流程

1. **启动 Gazebo 仿真**（终端 1）

```bash
./launch_gazebo.sh
```

2. **启动 SLAM 建图**（终端 2）

```bash
./launch_slam.sh
```

3. **键盘控制机器人移动**（终端 3）

```bash
ros2 run teleop_twist_keyboard teleop_twist_keyboard
```

### 里程计配置

可以选择不同的里程计数据源：

```bash
# 使用 Gazebo 地面真实数据（默认，适合仿真测试）
ODOM_SOURCE=ground_truth ./launch_gazebo.sh

# 使用腿部里程计（更接近真实机器人）
ODOM_SOURCE=leg_odometry ./launch_gazebo.sh
```

### 系统架构

```
┌─────────────────────────────────────────┐
│     footprint_to_odom_ekf               │
│  输入: odom/ground_truth 或 odom/raw    │
│  输出: odom → base_footprint TF         │
└────────────────┬────────────────────────┘
                 │
                 ↓
┌─────────────────────────────────────────┐
│     base_to_footprint_ekf               │
│  输入: 腿部里程计姿态 + IMU数据          │
│  输出: base_footprint 姿态估计          │
└────────────────┬────────────────────────┘
                 │
                 ↓
┌─────────────────────────────────────────┐
│         slam_toolbox                    │
│  输入: /scan 激光数据 + odom TF          │
│  输出: map → odom 校正 TF + /map        │
└─────────────────────────────────────────┘
```

---

**代码来源**

本项目基于以下开源项目：

- [anujjain-dev/unitree-go2-ros2](https://github.com/anujjain-dev/unitree-go2-ros2)
- [Unitree Robotics](https://github.com/unitreerobotics/unitree_ros) - Go2 机器人 URDF 模型
- [CHAMP](https://github.com/chvmp/champ) - 四足机器人控制器框架
- [CHAMP Robots](https://github.com/chvmp/robots) - 机器人配置和设置示例
