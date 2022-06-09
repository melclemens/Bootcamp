#!/bin/bash

if [ -d $HOME/research ]
then
  echo "Directory is present"
else
  mkdir $HOME/research
  echo "Directory research has been created successfully"
fi
 
