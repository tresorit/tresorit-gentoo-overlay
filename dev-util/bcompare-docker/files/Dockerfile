# To build: docker build --rm --build-arg USER --build-arg UID=`id -u` --build-arg GID=`id -g` -t docker-bcompare .
# To run: docker run --rm -t -i -w $PWD -v /tmp:/tmp -v /home/${USER}:/home/${USER} -e DISPLAY=unix$DISPLAY docker-bcompare

FROM debian:stretch

ARG USER
ARG UID
ARG GID

COPY bcompare.deb /bcompare.deb

RUN \
  apt-get update && \
  apt-get install -y gnupg fonts-hack-ttf && \
  { dpkg -i /bcompare.deb || true; } && \
  rm /bcompare.deb && \
  apt-get install -y -f && \
  rm -rf /var/lib/apt/lists/*

RUN \
  groupadd --gid ${GID} "${USER}" && \
  useradd --uid ${UID} --gid ${GID} "${USER}"

USER "${USER}"
WORKDIR /home/"${USER}"
VOLUME /home/"${USER}"

ENTRYPOINT ["/usr/bin/bcompare"]
