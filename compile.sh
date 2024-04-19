#!/bin/bash
# compile.sh
# A script to compile LaTeX figures in subdirectories named 'figures' within
# each directory, and then compile the main files in each directory.

function compile_figures() {
    local dir="$1"
    if [ ! -d "$dir/figures" ]; then return; fi
    cd "$dir/figures"
    for f in */_.tex; do
        if [ ! -f "$(dirname "$f")/_.tex" ]; then continue; fi
        cd "$(dirname "$f")"
        echo "========================="
        echo "Compiling figures $dir$(dirname "$f")"
        echo
        latexmk -pdf -shell-escape -interaction=nonstopmode _.tex
        cd ../
    done
    cd ../../
}

function compile_main() {
    local dir="$1"
    cd "$dir" || return
    echo "========================="
    echo "Compiling $dir"
    echo
    latexmk -pdf -quiet -interaction=nonstopmode
    cd ..
}

figures=false
main=false

while [[ $# -gt 0 ]]; do
    case $1 in
    --figures)
        figures=true
        shift
        ;;
    --main)
        main=true
        shift
        ;;
    *)
        echo "Unknown option: $1"
        exit 1
        ;;
    esac
done

for D in */; do
    if [ "$figures" = true ]; then
        compile_figures "$D"
    fi
    if [ "$main" = true ]; then
        compile_main "$D"
    fi
done
