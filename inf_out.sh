#!/bin/bash
#Script to put terraform output to a file after deployment
NOW=$( date '+%F_%H:%M' )
rm -rf dephosts*
terraform output | tee dephosts_$NOW
echo "output saved into file 'dephosts_...'"