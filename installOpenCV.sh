
# OpenCV
sudo apt install libgtk2.0-dev libavcodec-dev libavformat-dev libjpeg-dev libswscale-dev libtiff5-dev libgtk2.0-dev pkg-config libv4l-dev libhdf5-dev libhdf5-103 libjpeg8-dev 
libatlas-base-dev gfortran cheese fswebcam v4l-utils libgtk-3-dev -y
sudo apt install python3-numpy python3-dev

mkdir ~/Documents
cd ~/Documents

git clone https://gitee.com/mirrors/opencv.git
git clone https://gitee.com/mirrors/opencv_contrib.git

#>>>>> 编译OpenCV
cd ~/Documents/opencv
mkdir build
cd build

sudo cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=/home/${USERNAME}/Documents/opencv_contrib/modules \
    -D INSTALL_CXX_EXAMPLES=ON \
    -D WITH_LIBV4L=ON \
    -D WITH_GTK=ON \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D BUILD_opencv_python3=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_GENERATE_PKGCONFIG=YES \
    -D BUILD_EXAMPLES=ON ..
