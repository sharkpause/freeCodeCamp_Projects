if [[ -z $1 ]]; then
  echo 'Please provide an element as an argument.'
  exit
fi

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
# Above is example

if [[ $1 =~ ^[0-9]+$ ]]; then
  TEST=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
  if [[ -z $TEST ]]; then
    echo 'I could not find that element in the database.'
    exit
  fi

  $PSQL "SELECT name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number=$1" | sed '/^$/d' | sed 's/ //g' | while IFS="|" read -r NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT; do
    echo "The element with atomic number $1 is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
elif [[ $1 =~ (^[A-Z]$)|(^[A-Z][a-z]$) ]]; then
  TEST=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
  if [[ -z $TEST ]]; then
    echo 'I could not find that element in the database.'
    exit
  fi

  $PSQL "SELECT name, atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE symbol='$1'" | sed '/^$/d' | sed 's/ //g' | while IFS="|" read -r NAME ATOMIC_NUMBER TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT; do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($1). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
else
  TEST=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
  if [[ -z $TEST ]]; then
    echo 'I could not find that element in the database.'
    exit
  fi

  $PSQL "SELECT atomic_number, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE name='$1'" | sed '/^$/d' | sed 's/ //g' | while IFS="|" read -r ATOMIC_NUMBER SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT; do
    echo "The element with atomic number $ATOMIC_NUMBER is $1 ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $1 has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
fi