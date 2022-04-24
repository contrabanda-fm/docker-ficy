#!/bin/bash

# Set timezone, used by -l parameter
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

cd /opt/ficy && while true; do fIcy ${STREAMING_URL} | rotatelogs -l ${BACKUP_FILE_NAME}_%Y%m%d_%H%M.mp3 ${BACKUP_FILE_DURATION}; done
