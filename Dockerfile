FROM debian:buster-slim

RUN set -ex \
    # Official Mopidy install for Debian/Ubuntu along with some extensions
    # (see https://docs.mopidy.com/en/latest/installation/debian/ )
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl \
        gcc \
        gnupg \
        gstreamer1.0-alsa \
        gstreamer1.0-plugins-bad \
        python-crypto \
        python-dev \
 && curl -L https://apt.mopidy.com/mopidy.gpg | apt-key add - \
 && curl -L https://apt.mopidy.com/mopidy.list -o /etc/apt/sources.list.d/mopidy.list \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        python-spotify \
        mopidy \
        mopidy-soundcloud \
        mopidy-spotify \
        mopidy-scrobbler \
 && curl -L https://bootstrap.pypa.io/get-pip.py | python - \
 && pip install -U six pyasn1 requests[security] cryptography \
 && pip install \
        Mopidy-GMusic \
        Mopidy-Pandora \
        Mopidy-YouTube \
        Mopidy-Iris \
        pyopenssl \
        youtube-dl \
 && mkdir -p /var/lib/mopidy/.config \
 && ln -s /config /var/lib/mopidy/.config/mopidy \
    # Clean-up
 && apt-get purge --auto-remove -y \
        curl \
        gcc \
        gpg \
        python-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache \
    # snapcast fifo directory
 && mkdir -p /tmp/sharesound \
 && chown 0777 /tmp/sharesound

# Start helper script.
COPY mopidy_env_start.sh /mopidy_env_start.sh

# Default configuration.
COPY mopidy.conf /config/mopidy.conf

# Allows any user to run mopidy, but runs by default as a randomly generated UID/GID.
ENV HOME=/var/lib/mopidy
RUN set -ex \
  && usermod -G audio,sudo mopidy \
  && chown mopidy:audio -R $HOME /mopidy_env_start.sh \
  && chmod go+rwx -R $HOME /mopidy_env_start.sh

# Runs as mopidy user by default.
USER mopidy

VOLUME ["/var/lib/mopidy/local", "/var/lib/mopidy/media"]

EXPOSE 6600 6680 5555/udp

CMD ["/mopidy_env_start.sh"]
