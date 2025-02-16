#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

SECRET_NUMBER=$(( (RANDOM % 1000) + 1 ))
NUMBER_OF_GUESS=0

echo 'Enter your username:'
read USERNAME

GAMES_PLAYED=$($PSQL "SELECT games_played FROM players INNER JOIN games USING (player_id) WHERE username='$USERNAME'" | sed 's/ //g')

if [[ -z $GAMES_PLAYED || $GAMES_PLAYED = 0 ]]; then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
else
  BEST_GAME=$($PSQL "SELECT best_game FROM players INNER JOIN games USING (player_id) WHERE username='$USERNAME'" | sed 's/ //g')
  echo Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses.
fi

echo "Secret number: $SECRET_NUMBER"

echo 'Guess the secret number between 1 and 1000:'

while [[ $GUESS != $SECRET_NUMBER ]]; do
  read GUESS

  if [[ ! $GUESS =~ ^[0-9]+$ ]]; then
    echo 'That is not an integer, guess again:'
  else
    if (( $GUESS > $SECRET_NUMBER )); then
      echo "It's lower than that, guess again:"
    elif (( $GUESS < $SECRET_NUMBER )); then
      echo "It's higher than that, guess again:"
    fi
    (( ++NUMBER_OF_GUESSES ))
  fi
done

echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

if [[ -z $GAMES_PLAYED || $GAMES_PLAYED = 0 ]]; then
  (( ++GAMES_PLAYED ))
  INSERT_INTO_PLAYERS=$($PSQL "INSERT INTO players(username) VALUES('$USERNAME')")
  PLAYER_ID=$($PSQL "SELECT player_id FROM players WHERE username='$USERNAME'" | sed 's/ //g')
  INSERT_INTO_GAMES=$($PSQL "INSERT INTO games(player_id, games_played, best_game) VALUES($PLAYER_ID, $GAMES_PLAYED, $NUMBER_OF_GUESSES)")
else
  (( ++GAMES_PLAYED ))
  PLAYER_ID=$($PSQL "SELECT player_id FROM players WHERE username='$USERNAME'"  | sed 's/ //g')
  if [[ $NUMBER_OF_GUESSES < $BEST_GAME || -z $BEST_GAME ]]; then
    UPDATE_GAMES=$($PSQL "UPDATE games SET games_played=$GAMES_PLAYED, best_game=$NUMBER_OF_GUESSES WHERE player_id=$PLAYER_ID")
  else
    UPDATE_GAMES=$($PSQL "UPDATE games SET games_played=$GAMES_PLAYED, best_game=$BEST_GAME WHERE player_id=$PLAYER_ID")
  fi
fi