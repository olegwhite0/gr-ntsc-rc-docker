# gr-ntsc-rc-docker
docker container for project https://github.com/lscardoso/gr-ntsc-rc.git
added gnuradio block scheme for use hackrf-one - osmocomm source and frequency choose
docker container use Ubuntu 18.04 and gnuradio 3.7

building imagge cmd: docker build -t gnuradio-ubuntu18-ntsc-rc . ***
running  start_gr_ntsc.sh - run image gnuradio-ubuntu18-ntsc-rc and enable usb to container
