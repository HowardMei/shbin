#!/bin/sh

# Check if ~/.nvm is a directory
if [ -d "$HOME/.nvm" ]; then
  return 0
else
  return 1
fi
