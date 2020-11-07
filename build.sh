#!/bin/sh

# Remove old releases
rm -rf _build/prod/rel/*

# Build the image
docker build --rm -t badges-build -f Dockerfile.build .

# Run the container
docker run -it --rm --name badges-build -v $(pwd)/_build/prod/rel:/opt/app/_build/prod/rel badges-build
