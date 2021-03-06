#!/bin/bash

# A sample "external helper" for mount(8) that can be used to set up
# compatibility with the `mount` command. Edit the variables below, then install
# as /sbin/mount_gcsfuse on OS X or /sbin/mount.gcsfuse on Linux.

# Path to the gcsfuse_mount_helper binary obtained by running
#     go install github.com/googlecloudplatform/gcsfuse/gcsfuse_mount_helper
HELPER=/Users/jacobsa/go/bin/gcsfuse_mount_helper

# Path to a JSON key file downloaded from the Google Developers Console.
#
# This is necessary only if one of the other pieces of the default credentials
# logic (https://goo.gl/VYsojX) doesn't work for your situation. In particular,
# this is not necessary if you have run `gcloud auth login` or are running on a
# Google Cloud Engine VM that was created with the storage-full scope.
KEY_FILE=

# A $PATH-like string containing the gcsfuse binary and (on Linux) the
# fusermount binary.
WRAPPED_PATH=/Users/jacobsa/go/bin

# Set to an output file where you want stdout and stderr to go, or /dev/null, or
# a syslog "facility.priority" spec. See `man 1 daemon` for more.
OUTPUT=/tmp/gcsfuse.output

# Run under daemon so that we return to mount(8) immediately.
daemon \
  --env="PATH=$WRAPPED_PATH" \
  --env="GOOGLE_APPLICATION_CREDENTIALS=$KEY_FILE" \
  --output $OUTPUT \
  -- \
  $HELPER "$@"

exit
