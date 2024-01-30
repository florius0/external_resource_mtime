#!/bin/bash

rm -rf _build

echo 42 >lib/external_resource

mix compile

echo "Before mtime modification; should be 42"
mix eval "dbg ExternalResourceMtime.content()"

echo 43 >lib/external_resource

echo "Waiting 1 second & Modifying mtime of compile.elixir"

sleep 1

find _build -type f -path '*/lib/empay/external_resource_mtime/compile.elixir' -exec touch -m {} \;

echo "After mtime modification; should be 43"
mix eval "dbg ExternalResourceMtime.content()"
