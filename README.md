# docker-mopidy-snapcast

Run [Mopidy](https://www.mopidy.com) under docker, outputting to a named pipe for use by [snapcast](https://github.com/badaix/snapcast).

Includes the following plugins:
- [mopidy-spotify](https://docs.mopidy.com/en/latest/ext/backends/#mopidy-spotify)
- [mopidy-gmusic](https://github.com/mopidy/mopidy-gmusic)
- [mopidy-soundcloud](https://github.com/mopidy/mopidy-soundcloud)
- [mopidy-scrobbler](https://github.com/mopidy/mopidy-scrobbler)
- [mopidy-pandora](https://github.com/jcass77/mopidy-pandora)
- [mopidy-youtube](https://github.com/mopidy/mopidy-youtube)
- [mopidy-iris](https://github.com/jaedb/Iris)

**Heavily** based on [wernight/docker-mopidy](https://github.com/wernight/docker-mopidy).

## Usage

    docker run --rm --user ${UID}:${GID} \
    -v /tmp/sharesound:/tmp/sharesound \
    -v $HOME/music:/var/lib/mopidy/media \
    -p 6600:6600 -p 6680:6680 \
    sharktamer/docker-mopidy-snapcast

Using the above settings, mopidy can be reached with mpd clients on port `6600` and Iris can be accessed from http://localhost:6680/iris.

This image can also be dropped into [nolte/docker_compose-audiostation](https://github.com/nolte/docker_compose-audiostation) to include the above plugins.

Plugins can be configured by setting the below environment variables (using docker's `-e` flag):

    SPOTIFY_USERNAME
    SPOTIFY_PASSWORD
    SPOTIFY_CLIENT_ID
    SPOTIFY_CLIENT_SECRET
    SPOTIFY_BITRATE (defaults to 320)

    LASTFM_USERNAME
    LASTFM_PASSWORD

    GMUSIC_USERNAME
    GMUSIC_PASSWORD
    GMUSIC_DEVICE_ID
    GMUSIC_BITRATE (defaults to 320)

If all non defaulting entries from each plugin block are not included, plugin will be disabled.
