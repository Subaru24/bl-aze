#!/bin/sh
printf '\033c\033]0;%s\a' Project Maze
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Project Maze.x86_64" "$@"
