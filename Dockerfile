FROM ubuntu:18.04

# =============================================
# Метаданные (Labels)
# =============================================
LABEL maintainer="olegwhite0@gmail.com"
LABEL version="1.0.0"
LABEL description="this is docker assembly from git https://github.com/lscardoso/gr-ntsc-rc.git , \
NTSC receiver and transmitter for 5 GHz drones use osmocomm hackkrf-one and gnuradio 3.7"
LABEL vendor="Oleg White"
LABEL org.opencontainers.image.title="gr-ntsc-rc"
LABEL org.opencontainers.image.version="1.0.0"
LABEL org.opencontainers.image.description="osmocomm hackkrf-one and gnuradio 3.7 watch analog video"
LABEL org.opencontainers.image.authors="Oleg White <olegwhite0@gmail.com>"


# Обновление пакетов и установка зависимостей
ENV TZ=Asia/Yekaterinburg
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y \
gnupg \
software-properties-common \
wget

# Добавление репозитория GNURadio
RUN apt-get update && \
apt-get install -y \
gnuradio \
swig \
gr-osmosdr \
xterm \
python3-pip \
hackrf \
git \
cmake \
x11-apps

WORKDIR /opt/
RUN git clone https://github.com/lscardoso/gr-ntsc-rc.git

WORKDIR /opt/gr-ntsc-rc
RUN mkdir build
WORKDIR /opt/gr-ntsc-rc/build
RUN cmake .. 
RUN make
RUN make install
RUN ldconfig
RUN apt-get update && \ 
apt-get install -y \
libsdl2-2.0-0 \
libsdl2-dev

COPY osmocomm_NTSC_Video_RX.grc /opt/gr-ntsc-rc/examples/osmocomm_NTSC_Video_RX.grc
# Создание рабочей директории
WORKDIR /opt/gr-ntsc-rc 

# Команда по умолчанию

CMD ["sh", "-c", "gnuradio-companion examples/osmocomm_NTSC_Video_RX.grc && exec /bin/bash"]
