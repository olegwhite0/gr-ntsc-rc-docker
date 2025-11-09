xhost +local:docker
sudo docker run -it --rm     \
-e DISPLAY=$DISPLAY     \
-v /tmp/.X11-unix:/tmp/.X11-unix     \
-v /tmp/xauth_list:/root/.Xauthority     \
--device /dev/bus/usb \
    --privileged \
-v $(pwd):/workspace     gnuradio-ubuntu18-ntsc-rc
