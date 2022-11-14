FROM ros:humble-ros-core

COPY --from=microros/micro-ros-agent:humble /uros_ws /uros_ws
WORKDIR /uros_ws

ENV RMW_IMPLEMENTATION=rmw_fastrtps_cpp

RUN echo ". /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
RUN echo ". /uros_ws/install/setup.bash" >> ~/.bashrc

# setup entrypoint
COPY ./micro-ros_entrypoint.sh /
ENTRYPOINT ["/bin/sh", "/micro-ros_entrypoint.sh"]
CMD ["--help"]