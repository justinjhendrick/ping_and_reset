#!/bin/sh

# usage:
# ./ping_and_reset [<url>]

if [ -z ${1+x} ]; then
  URL=google.com;
else
  URL=$1;
fi

echo $URL;

# Measure Internet connectivity by connection to @url.
ping $URL |
  while IFS= read -r line
    do
        echo "$line"
        echo test
  done

# If we disconnect. Reset wifi.
