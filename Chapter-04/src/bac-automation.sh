#!/bin/bash

# BINARY ANALYSIS AUTOMATION
# BY - Michael Born
# DATE - 2019


if [ $# -lt 2 ] || [$# -gt 2 ]
then
    echo "Not enough arguments: usage = $0 <binary file> <output file>";

else
    BINARY=$1;
    OUTPUTFILE=$2;

    # SETUP OUTPUT INFORMATION
    echo "This output created by $USER on $(date)" |tee $OUTPUTFILE;
    echo |tee -a $OUTPUTFILE;
    echo |tee -a $OUTPUTFILE;

   # FILE
    echo "FILE TYPE INFORMATION" | tee $OUTPUTFILE;
    echo |tee -a $OUTPUTFILE
    file $BINARY |tee -a $OUTPUTFILE;
    echo |tee -a $OUTPUTFILE;
    echo |tee -a $OUTPUTFILE;

    # STRINGS
    echo "STRINGS INFORMATION" |tee -a $OUTPUTFILE;
    echo |tee -a $OUTPUTFILE;
    strings -s "  |  " $BINARY |tee -a $OUTPUTFILE;
    echo |tee -a $OUTPUTFILE;
    echo |tee -a $OUTPUTFILE

    # READELF
    echo "READELF ALL" |tee -a $OUTPUTFILE;
    echo |tee -a $OUTPUTFILE;
    readelf -a -W $BINARY |tee -a $OUTPUTFILE;
    echo |tee -a $OUTPUTFILE;
    echo |tee -a $OUTPUTFILE;

    # OBJDUMP
    echo "OBJDUMP EXECUTABLE" |tee -a $OUTPUTFILE;
    echo |tee -a $OUTPUTFILE
    objdump -d -M intel $BINARY |tee -a $OUTPUTFILE;
    echo |tee -a $OUTPUTFILE;
    echo |tee -a $OUTPUTFILE;
fi
