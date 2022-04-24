<!-- START doctoc.sh generated TOC please keep comment here to allow auto update -->
<!-- DO NOT EDIT THIS SECTION, INSTEAD RE-RUN doctoc.sh TO UPDATE -->
**:book: Table of Contents**

- [docker-ficy](#docker-ficy)
- [Usage](#usage)
- [Docker compose](#docker-compose)
- [Credits](#credits)

<!-- END doctoc.sh generated TOC please keep comment here to allow auto update -->
# docker-ficy

Dockerized ficy, "An icecast/shoutcast stream grabber suite"

# Usage

Run below command adjusting below variables:

* STREAMING_URL. Specify an HTTP URL of a icecast/shoutcast mountpoint
* BACKUP_FILE_NAME. The filename that it will be written to docker volume
* BACKUP_FILE_DURATION. Expressed in seconds, the duration of the .mp3 file generated
* TZ. Timezone

```
sudo docker run \
  --name ficy \
  -e BACKUP_FILE_DURATION=10 \
  -e BACKUP_FILE_NAME=my_facy_backup \
  -e STREAMING_URL=http://contrabanda.org:8000/contrabanda \
  -e TZ=Europe/Madrid \
  -v backup:/opt/ficy \
  -d ghcr.io/contrabanda-fm/docker-ficy:latest
```

# Docker compose

1. Configure variables

1.1. Generate .env file:

```
cp .env.example .env
```

1.2. Edit file:

```
vim .env
```

And adjust below variables:

* STREAMING_URL. Specify an HTTP URL of a icecast/shoutcast mountpoint
* BACKUP_FILE_NAME. The filename that it will be written to docker volume
* BACKUP_FILE_DURATION. Expressed in seconds, the duration of the .mp3 file generated
* TZ. Timezone

2. Bring up the docker contaner:

```
sudo docker-compose up -d --force-recreate
```

3. Test

3.1. Check that the docker container is running

```
docker ps | grep ficy
```

Expected output similar to:

```
bd04c83a33e4   localhost/ficy   "/entrypoint.sh"   26 seconds ago   Up 25 seconds             ficy
```

So 5th column ("STATUS") should contain the word "Up"

3.2. Check that the docker container is actually producing audio (.mp3) files

3.2.1. Get the docker volume path

```
sudo docker inspect volume-ficy  | grep Mountpoint | cut -d '"' -f4
```

Expected output similar to:

```
/var/lib/docker/volumes/volume-ficy/_data
```

3.2.2. List the content of the dir:

```
sudo ls -la /var/lib/docker/volumes/volume-ficy/_data
```

Expected output similar to:

```
-rw-r--r-- 1 root root 1104600 Apr 24 12:47 backup_20220424_1047.mp3
-rw-r--r-- 1 root root 1296400 Apr 24 12:48 backup_20220424_1048.mp3
```

3.3. Try reproducing one of the files

```
mplayer /var/lib/docker/volumes/volume-ficy/_data/backup_20220424_1047.mp3
```

Expected the content of the streaming at that time (expressed in UTC)

4. Cleanup

```
sudo docker-compose down -v
```

Expected output similar to:

```
Stopping ficy ... done
Removing ficy ... done
Removing network docker-ficy_default
Removing volume volume-ficy
```

# Credits

Wonderful project, [fIcy](https://gitlab.com/wavexx/fIcy)
