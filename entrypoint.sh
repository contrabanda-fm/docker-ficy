#!/bin/bash

#cd /opt/ficy && while true; do fIcy http://contrabanda.org:8000/contrabanda | rotatelogs contrabanda_%Y%m%d_%H%M.mp3 10; done

cd /opt/ficy && while true; do fIcy ${STREAMING_URL} | rotatelogs ${BACKUP_FILE_NAME}_%Y%m%d_%H%M.mp3 ${BACKUP_FILE_DURATION}; done
