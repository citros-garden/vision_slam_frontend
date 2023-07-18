FROM althack/ros2:foxy-dev 

RUN apt update && apt upgrade

# Installing dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get -y install --no-install-recommends cmake \
    gcc \
    g++ \
    python3-dev \
    python3-numpy \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libgstreamer-plugins-base1.0-dev \
    libgstreamer1.0-dev \
    libgtk-3-dev \
    libvtk6-dev \ 
    qt5-default \
    zlib1g-dev \
    libjpeg-dev \
    libwebp-dev \
    libpng-dev \
    libtiff5-dev \
    libopenexr-dev \
    libgdal-dev \
    libpng-dev \
    libjpeg-dev \
    libopenexr-dev \
    libtiff-dev \
    libdc1394-22-dev \ 
    libtbb-dev \
    libeigen3-dev \
    libwebp-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    curl \
    ros-foxy-rosbridge-suite \
    build-essential \ 
    python-dev \
    python-tk \
    python-numpy\
    python3-dev\
    python3-tk \
    python3-numpy\
    python3-rospkg\
    ant \
    default-jdk \
    doxygen \
    unzip \
    wget \
   # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=dialog

# Set up auto-source of workspace for ros user
ARG WORKSPACE

# Install ROS1
RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install -y ros-noetic-desktop-full

# Install OpenCV 3.2.0
RUN wget https://github.com/opencv/opencv/archive/3.2.0.zip -O OpenCV320.zip

RUN git clone -b 3.2.0 https://github.com/opencv/opencv_contrib.git

RUN unzip OpenCV320.zip && \
    # add definitions for ffmpeg
    echo "#define AV_CODEC_FLAG_GLOBAL_HEADER (1 << 22)" | cat - /opencv-3.2.0/modules/videoio/src/cap_ffmpeg_impl.hpp > temp && mv temp /opencv-3.2.0/modules/videoio/src/cap_ffmpeg_impl.hpp && \
    echo "#define CODEC_FLAG_GLOBAL_HEADER AV_CODEC_FLAG_GLOBAL_HEADER" | cat - /opencv-3.2.0/modules/videoio/src/cap_ffmpeg_impl.hpp > temp && mv temp /opencv-3.2.0/modules/videoio/src/cap_ffmpeg_impl.hpp && \ 
    echo "#define AVFMT_RAWPICTURE 0x0020" | cat - /opencv-3.2.0/modules/videoio/src/cap_ffmpeg_impl.hpp > temp && mv temp /opencv-3.2.0/modules/videoio/src/cap_ffmpeg_impl.hpp && \
    cd opencv-3.2.0 && \
    mkdir build && \
    cd build && \
    cmake -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules -DOPENCV_ENABLE_NONFREE=ON -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_opencv_xfeatures2d=ON -DBUILD_opencv_python3=OFF .. && \
    make -j$(nproc) && \
    make install && \
    ldconfig

RUN rm -rf /etc/ros/rosdep/sources.list.d/20-default.list && rosdep init && rosdep update
 
RUN echo "if [ -f ${WORKSPACE}/install/setup.bash ]; then source ${WORKSPACE}/install/setup.bash; fi" >> /home/ros/.bashrc