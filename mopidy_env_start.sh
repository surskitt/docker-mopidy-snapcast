#!/usr/bin/env bash

mopidy --config /config/mopidy.conf:<(

# spotify settings
[ -n "${SPOTIFY_USERNAME}" ] && \
    [ -n "${SPOTIFY_PASSWORD}" ] && \
    [ -n "${SPOTIFY_CLIENT_ID}" ] && \
    [ -n "${SPOTIFY_CLIENT_SECRET}" ] && cat << EOF
[spotify]
enabled       = true
bitrate       = ${SPOTIFY_BITRATE:-320}
username      = ${SPOTIFY_USERNAME}
password      = ${SPOTIFY_PASSWORD}
client_id     = ${SPOTIFY_CLIENT_ID}
client_secret = ${SPOTIFY_CLIENT_SECRET}

EOF

# gmusic settings
[ -n "${GMUSIC_USERNAME}" ] && \
    [ -n "${GMUSIC_PASSWORD}" ] && \
    [ -n "${GMUSIC_DEVICE_ID}" ] && cat << EOF
[gmusic]
enabled  = true
bitrate  = ${GMUSIC_BITRATE:-320}
username = ${GMUSIC_USERNAME}
password = ${GMUSIC_PASSWORD}
deviceid = ${GMUSIC_DEVICE_ID}

EOF

# scrobbler settings
[ -n "${LASTFM_USERNAME}" ] && \
    [ -n "${LASTFM_PASSWORD}" ] && cat << EOF
[scrobbler]
enabled  = true
username = ${LASTFM_USERNAME}
password = ${LASTFM_PASSWORD}

EOF

)
