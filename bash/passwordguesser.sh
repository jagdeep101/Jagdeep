#!/bin/bash
# This script demonstrates testing to see if 2 strings are the same

newString="TestString"
referenceString="password"

[ $newString = $referenceString ] && echo "You guessed the password!" || echo "The password eludes you..."

# TASK 1: Improve it by asking the user for a password guess instead of using inline literal data

prompt="Guess the password : "
read -p "$prompt" newString

referenceString="password"
[ $newString = $referenceString ] && echo "You guessed the password!" || echo "The password eludes you..."

# TASK 2: Improve it by rewriting it to use the if command

prompt="Guess the password : "
read -p "$prompt" newString

if [ $newString = $referenceString ]
then
  echo "You guessed the password!"
else
  echo "The password eludes you..."
fi

# TASK 3: Improve it by giving them 3 tries to get it right before failing (test 3 times but only if necessary)
#           *** Do not use the exit command

echo "Guess the password within three tries"

  trynum=3

  for ((x=1; x<=$trynum; x++)) ;
  do
    prompt="Guess the password: "
    read -p "$prompt" newString
    if [ $newString = $referenceString ]
    then
      echo "You gussed the password correctly!"
      break
    else
      echo "The password eludes you..."
    fi
    if [ $x -ge $trynum ] ; then echo "The password eludes you..."
      break
    fi
  done
