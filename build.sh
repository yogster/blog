#!/bin/sh

# Delete previous build
rm -r $1/public

# Build site again
hugo -s $1

# Add new version of site to ipfs
NEW_HASH=$(ipfs add -r $1/public -Q)

#Publish new version of site to ipns
ipfs name publish $NEW_HASH

# If a different hash had been published before, remove pin
if [ -e $1/published_hash ]; then
    PUBLISHED_HASH=$(cat $1/published_hash)
fi

if [ -n "$PUBLISHED_HASH" ] && [ $PUBLISHED_HASH != $NEW_HASH ]; then
    ipfs pin rm $PUBLISHED_HASH
fi

# Save published hash so it can be removed when the next version is published
echo $NEW_HASH > published_hash