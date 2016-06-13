#!/bin/bash

# mov.sh

cp ../mergers/mov.sh mov.sh;
./mov.sh;
rm -rf bin
rm mov.sh
echo "Passed";
