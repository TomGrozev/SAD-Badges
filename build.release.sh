#!/usr/bin/env bash

# exit on error
set -o errexit

# Initial Setup
mix deps.get --only prod
MIX_ENV=prod mix compile

# Compile assets
npm install --prefix ./assets
npm run deploy --prefix ./assets
mix phx.digest

# Build the release and overwrite the existing release directory
MIX_ENV=prod mix release --overwrite


# Perform migrations
_build/prod/rel/badges/bin/badges eval "Badges.Release.migrate"