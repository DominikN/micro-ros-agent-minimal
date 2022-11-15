FROM ros:humble-ros-core

COPY --from=microros/micro-ros-agent:humble /uros_ws /uros_ws
COPY --from=microros/micro-ros-agent:humble /tmp/disable_fastdds_shm_localhost_only.xml /tmp/disable_fastdds_shm_localhost_only.xml
COPY --from=microros/micro-ros-agent:humble /tmp/disable_fastdds_shm.xml /tmp/disable_fastdds_shm.xml

WORKDIR /uros_ws

ENV RMW_IMPLEMENTATION=rmw_fastrtps_cpp
ENV MICROROS_DISABLE_SHM=1

RUN echo ". /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
RUN echo ". /uros_ws/install/setup.bash" >> ~/.bashrc

# setup entrypoint
COPY ./micro-ros_entrypoint.sh /

ENTRYPOINT ["/bin/sh", "/micro-ros_entrypoint.sh"]
CMD ["--help"]