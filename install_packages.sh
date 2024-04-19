#!/bin/bash
# install_packages.sh
# Script to install LaTeX packages listed in requirements.txt using tlmgr.
# Note: The requirements.txt file is not an exhaustive list of all the packages required by the project.

echo "Updating tlmgr..."
tlmgr update --self
echo

installed_packages=$(tlmgr list --only-installed --data name)

while IFS= read -r package; do
    if grep -q "^$package$" <<<"$installed_packages"; then
        echo "$package is already installed. Skipping."
    else
        echo "Installing $package..."
        tlmgr install "$package"
    fi
    echo
done <requirements.txt

echo "Installation completed."
