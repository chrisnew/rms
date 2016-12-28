FROM debian:jessie

RUN apt-get update \
  &&  apt-get -yqq install curl bzip2 build-essential libasound2-dev \
  &&  mkdir -p /usr/src && cd /usr/src \
  &&  curl -sf -o pjproject.tar.bz2 -L http://www.pjsip.org/release/2.5.5/pjproject-2.5.5.tar.bz2 \
  &&  tar -xvjf pjproject.tar.bz2 \
  &&  rm pjproject.tar.bz2 \
  &&  cd pjproject* \
  &&  ./configure \
  &&  make dep \
  &&  make \
  &&  cp pjsip-apps/bin/pjsua-*gnu /usr/bin/pjsua

RUN apt-get install -yqq pulseaudio

COPY track.wav /data/track.wav
COPY pjsua.cfg /data/pjsua.cfg
COPY callees.txt /data/callees.txt
COPY entrypoint.sh /entrypoint.sh

CMD /entrypoint.sh

