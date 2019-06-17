#!/bin/bash
#
# this script demonstrates doing arithmetic

# Improve this script by asking the user to supply the two numbers
# Improve this script by demonstrating using subtraction and multiplication
# Improve this script by demonstrating the modulus operation
#   - the output should look something like:
#   - first divided by second gives X with a remainder of Y
# Improve this script by calculating and displaying the first number raised to the power of the second number

#Asking user to enter two numbers
prompt="Enter the two numbers : "
read -p "$prompt" firstnum secondnum

# Operations

sum=$((firstnum + secondnum))
minus=$((firstnum - secondnum))
dividend=$((firstnum / secondnum))
modulus=$((firstnum % secondnum))
fpdividend=$(awk "BEGIN{printf \"%.2f\", $firstnum/$secondnum}")
multiply=$((firstnum * secondnum))
raise_to=$((firstnum**secondnum))

#Main Program

cat <<EOF

$firstnum plus $secondnum is $sum

$firstnum minus $secondnum is $minus

$firstnum multiplied by $secondnum is $multiply

$firstnum divided by $secondnum is $dividend with a remainder of $modulus
  - More precisely, it is $fpdividend

$firstnum raised to $secondnum is $raise_to
EOF
