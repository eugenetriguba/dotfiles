#!/usr/bin/env sh

# Syncronize X clipboard and selection buffers.
if [ -x /usr/bin/autocutsel ]; then
    # Keep the clipboard in sync with the primary buffer.
    autocutsel -selection CLIPBOARD -fork
    # Keep the primary in sync with the clipboard buffer.
    autocutsel -selection PRIMARY -fork
fi
