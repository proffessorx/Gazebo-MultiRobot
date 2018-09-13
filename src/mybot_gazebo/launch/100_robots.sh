#!/bin/bash

#number of robots
n=100

LAUNCH_FILE=/home/cch-student/catkin_ws/src/gazebo_multirobot/src/mybot_gazebo/launch/costum_number_robots.launch

echo "<launch>" > $LAUNCH_FILE

echo -e "  <param name=\"robot_description_robotino\" command=\"\$(find xacro)/xacro.py \$(find robotino_description)/urdf/robotino.urdf.xacro\" />"

for ((i=0; i<n; i++)); do
    namespace="robot$i"
    namespace_tf="tf_robot$i"
    name="Robot$i"

    echo -e "  <group ns=\"$namespace\">"
    echo -e "    <param name=\"tf_prefix\" value=\"$namespace_tf\"/>"


    echo -e "    <include file=\"\$(find mybot_gazebo)/launch/robotino/robot.launch\">"

    echo -e "      <arg name=\"init_pose\" value=\"-x $i -y 1 -z 0\"/>"
    echo -e "      <arg name=\"robot_name\"  value=\"$name\"/>"
    echo -e "    </include>"

    echo -e "  </group>"

done >> $LAUNCH_FILE
echo -e "</launch>" >> $LAUNCH_FILE

roslaunch $LAUNCH_FILE
