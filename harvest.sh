#! /bin/bash

failCounter=100
sysno=0

while [ $failCounter -gt 0 ]
do
  if [ $(curl -s localhost:3000/feeder/sysno/$sysno) = "ok" ]
  then
    failCounter=100
  else
    ((failCounter--))
  fi
  ((sysno++))
done

