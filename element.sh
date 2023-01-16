#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
echo -e "Please provide an element as an argument."
fi
if [[ $1 ]]
then
# if the argument is a number
  if [[ $1 =~ ^[0-9]+$ ]]
    then
    GET_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $1")
    GET_SYMBOL=($($PSQL "SELECT symbol FROM elements WHERE atomic_number = $1"))
    GET_TYPE=$($PSQL "SELECT type FROM properties LEFT JOIN types ON properties.type_id=types.type_id WHERE atomic_number=$1")
    GET_ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties LEFT JOIN types ON properties.type_id=types.type_id WHERE atomic_number=$1")
    GET_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties LEFT JOIN types ON properties.type_id=types.type_id WHERE atomic_number=$1")
    GET_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties LEFT JOIN types ON properties.type_id=types.type_id WHERE atomic_number=$1")

    # if the atomic number is not in the database say so
      if [[ -z $GET_NAME ]]
        then
        echo "I could not find that element in the database."
    # if the atomic number is in the database print the information
      else
      echo -e "The element with atomic number" $1 "is" $GET_NAME' ('$GET_SYMBOL')'. "It's a"$GET_TYPE", with a mass of"$GET_ATOMIC_MASS" amu."$GET_NAME "has a melting point of" $GET_MELTING_POINT "celsius and a boiling point of"$GET_BOILING_POINT "celsius."
      fi
  # if the argument is a symbol 
  elif [[ $1 =~ ^[A-Za-z]{1,3}$ ]]
    then
    GET_NAME_BY_SYMBOL=$($PSQL "SELECT name FROM elements WHERE symbol = '$1'")
    GET_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
    GET_TYPE_BY_SYMBOL=$($PSQL "SELECT type FROM properties LEFT JOIN types ON properties.type_id=types.type_id WHERE atomic_number=$GET_ATOMIC_NUMBER")
    GET_ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties LEFT JOIN types ON properties.type_id=types.type_id WHERE atomic_number=$GET_ATOMIC_NUMBER")
    GET_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties LEFT JOIN types ON properties.type_id=types.type_id WHERE atomic_number=$GET_ATOMIC_NUMBER")
    GET_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties LEFT JOIN types ON properties.type_id=types.type_id WHERE atomic_number=$GET_ATOMIC_NUMBER")

      if [[ -z $GET_NAME_BY_SYMBOL ]]
        then
        echo "I could not find that element in the database."
      else
      echo -e "The element with atomic number" $GET_ATOMIC_NUMBER "is" $GET_NAME_BY_SYMBOL '('$1')'. "It's a"$GET_TYPE_BY_SYMBOL", with a mass of"$GET_ATOMIC_MASS" amu."$GET_NAME_BY_SYMBOL "has a melting point of" $GET_MELTING_POINT "celsius and a boiling point of"$GET_BOILING_POINT "celsius."
      fi
  # if the argument is a name
 elif [[ $1 =~ ^[A-Za-z]{4,}$ ]]
    then
    GET_SYMBOL_BY_NAME=($($PSQL "SELECT symbol FROM elements WHERE name = '$1'"))
    GET_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
    GET_TYPE_BY_NAME=$($PSQL "SELECT type FROM properties LEFT JOIN types ON properties.type_id=types.type_id WHERE atomic_number=$GET_ATOMIC_NUMBER")
    GET_ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties LEFT JOIN types ON properties.type_id=types.type_id WHERE atomic_number=$GET_ATOMIC_NUMBER")
    GET_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties LEFT JOIN types ON properties.type_id=types.type_id WHERE atomic_number=$GET_ATOMIC_NUMBER")
    GET_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties LEFT JOIN types ON properties.type_id=types.type_id WHERE atomic_number=$GET_ATOMIC_NUMBER")

    if [[ -z $GET_SYMBOL_BY_NAME ]]
    then
    echo "I could not find that element in the database."
    else
     echo -e "The element with atomic number" $GET_ATOMIC_NUMBER "is" $1 "("$GET_SYMBOL_BY_NAME")". "It's a"$GET_TYPE_BY_NAME", with a mass of"$GET_ATOMIC_MASS" amu. "$1 "has a melting point of" $GET_MELTING_POINT "celsius and a boiling point of"$GET_BOILING_POINT "celsius."
    fi
  else
    echo -e "I could not find that element in the database."
  fi
fi
