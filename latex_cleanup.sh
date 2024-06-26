#!/bin/bash
# latex_cleanup.sh
# Clean up all the temporary files generated by LaTeX.

find . -type d \( -path './.git' \) -prune -o -exec sh -c 'cd "{}" && latexmk -C && rmdir "$PWD"' \;
