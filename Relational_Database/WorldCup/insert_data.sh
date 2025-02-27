#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo "$($PSQL "TRUNCATE teams, games")"

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS; do
  if [[ $YEAR == 'year' ]]; then 
    continue
  fi

  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  
  if [[ -z $WINNER_ID ]]; then
    INSERT_WINNER_ID=$($PSQL "INSERT INTO teams (name) VALUES ('$WINNER')")

    if [[ $INSERT_WINNER_ID == 'INSERT 0 1' ]]; then
      echo "Insert $WINNER into teams table"
    fi

    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  fi

  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
  
  if [[ -z $OPPONENT_ID ]]; then
    INSERT_OPPONENT_ID=$($PSQL "INSERT INTO teams (name) VALUES ('$OPPONENT')")

    if [[ $INSERT_OPPONENT_ID == 'INSERT 0 1' ]]; then
      echo "Insert $OPPONENT into teams table"
    fi

    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
  fi

  #echo "INSERT INTO games (\"year\", round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);"
  qINSERT_GAMES_ROWS=$($PSQL "INSERT INTO games (\"year\", round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
done
