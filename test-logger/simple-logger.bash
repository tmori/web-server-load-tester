#!/bin/bash

#TODO log file

function tlog()
{
    echo "INFO: `date` : $*"
}

function terror()
{
    echo "ERROR: `date` : $*"
}
