ARG IMAGE

ARG VERSION

FROM $IMAGE:$VERSION

# IMPORTANT: remeber to declare ARG values AFTER FROM sentence....

MAINTAINER javi@legido.com

RUN apt-get update && apt-get install -y \
  apache2-utils \
  build-essential \
  git \
  procps \
  && rm -rf /var/lib/apt/lists/*

RUN cd && \
  git clone https://gitlab.com/wavexx/fIcy && \
  ls -la && \
  cd fIcy && \
  make && \
  make install

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
