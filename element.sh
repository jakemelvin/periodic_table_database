#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"
PASSING="";
if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  if [[ "$1" =~ ^[-+]?[0-9]+$ && -z $PASSING ]]
  then
    SELECTED_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
    if [[ -z $SELECTED_ATOMIC_NUMBER ]]
    then
      echo I could not find that element in the database.
    else
      PASSING=1;
      GET_ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$SELECTED_ATOMIC_NUMBER")
      GET_ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$SELECTED_ATOMIC_NUMBER")
      GET_ELEMENT_TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number=$SELECTED_ATOMIC_NUMBER")
      GET_ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$SELECTED_ATOMIC_NUMBER")
      GET_ELEMENT_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$SELECTED_ATOMIC_NUMBER")
      GET_ELEMENT_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$SELECTED_ATOMIC_NUMBER")
      echo "The element with atomic number $SELECTED_ATOMIC_NUMBER is $GET_ELEMENT_NAME ($GET_ELEMENT_SYMBOL). It's a $GET_ELEMENT_TYPE, with a mass of $GET_ELEMENT_MASS amu. $GET_ELEMENT_NAME has a melting point of $GET_ELEMENT_MELTING_POINT celsius and a boiling point of $GET_ELEMENT_BOILING_POINT celsius."
    fi
  fi
  if [[ "$1" =~ ^[[:alpha:]]+$ && ${#1} -le 2 && -z $PASSING ]]
  then
    SELECTED_ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1'")
    if [[ -z $SELECTED_ELEMENT_SYMBOL ]]
    then
      echo I could not find that element in the database.
    else
      PASSING=1
      SELECTED_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$SELECTED_ELEMENT_SYMBOL'")
      GET_ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$SELECTED_ATOMIC_NUMBER")
      GET_ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$SELECTED_ATOMIC_NUMBER")
      GET_ELEMENT_TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number=$SELECTED_ATOMIC_NUMBER")
      GET_ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$SELECTED_ATOMIC_NUMBER")
      GET_ELEMENT_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$SELECTED_ATOMIC_NUMBER")
      GET_ELEMENT_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$SELECTED_ATOMIC_NUMBER")
      echo "The element with atomic number $SELECTED_ATOMIC_NUMBER is $GET_ELEMENT_NAME ($GET_ELEMENT_SYMBOL). It's a $GET_ELEMENT_TYPE, with a mass of $GET_ELEMENT_MASS amu. $GET_ELEMENT_NAME has a melting point of $GET_ELEMENT_MELTING_POINT celsius and a boiling point of $GET_ELEMENT_BOILING_POINT celsius."
    fi
  fi
  if [[ "$1" =~ ^[a-zA-Z]{2,13}$ && -z $PASSING ]]
  then
    SELECTED_ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE name='$1'")
    if [[ -z $SELECTED_ELEMENT_NAME ]]
    then
      echo I could not find that element in the database.
    else
      PASSING=1
      SELECTED_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$SELECTED_ELEMENT_NAME'")
      GET_ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$SELECTED_ATOMIC_NUMBER")
      GET_ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$SELECTED_ATOMIC_NUMBER")
      GET_ELEMENT_TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number=$SELECTED_ATOMIC_NUMBER")
      GET_ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$SELECTED_ATOMIC_NUMBER")
      GET_ELEMENT_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$SELECTED_ATOMIC_NUMBER")
      GET_ELEMENT_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$SELECTED_ATOMIC_NUMBER")
      echo "The element with atomic number $SELECTED_ATOMIC_NUMBER is $GET_ELEMENT_NAME ($GET_ELEMENT_SYMBOL). It's a $GET_ELEMENT_TYPE, with a mass of $GET_ELEMENT_MASS amu. $GET_ELEMENT_NAME has a melting point of $GET_ELEMENT_MELTING_POINT celsius and a boiling point of $GET_ELEMENT_BOILING_POINT celsius."
    fi
  fi
fi