#!/bin/bash

rm -rf _build
rm -rf _build.tar.gz

echo 42 >lib/external_resource

mix compile

echo "Before mtime modification; should be 42"
mix eval "dbg ExternalResourceMtime.content()"

echo "Caching _build to _build.tar.gz"

tar -czf _build.tar.gz _build # simulate caching _build

rm -rf _build                  # delete _build to simulate a fresh checkout in CI
echo 43 >lib/external_resource # modify external_resource_mtime to simulate a change in the dependency

echo "Waiting 1 second & Restoring _build from _build.tar.gz"

sleep 1

tar -xzf _build.tar.gz # simulate restoring _build from cache

echo "After mtime modification; should be 43"
mix eval "dbg ExternalResourceMtime.content()"
