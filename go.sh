#!/bin/bash

ASSIGNMENT="ForLoopPractice"
SUBMISSION_URL="http://localhost:8080"

CHECKPOINTS=false
CHECKPOINT_VALUES="1 2 3 4"

if [ $ASSIGNMENT == "AssignmentName" ]; then
  echo "Please set assignment name in go.sh"
  echo "This should match the class name used for submission."
  exit 1
fi

if [ $SUBMISSION_URL == "https://Project-Name.username.repl.co" ]; then
  echo "Please set submission URL in go.sh"
  echo "This should be the URL used where you are running the grading server."
  exit 1
fi

if ! [ -f $ASSIGNMENT.java ]; then
  echo "In go.sh, ASSIGNMENT is set to $ASSIGNMENT, but $ASSIGNMENT.java does not exist."
  exit 1
fi

if [ $CHECKPOINTS == true ]; then
  CHECKPOINT=$(cat $ASSIGNMENT.java | grep -i -o 'Checkpoint\s*=\s*\S\+' | cut -d= -f2 | xargs echo)
  if [ -z "$CHECKPOINT" ]; then
    echo "No checkpoint found; ensure you have a line like \"// Checkpoint = [number]\" in $ASSIGNMENT.java"
    exit 1
  fi
  if [[ " $CHECKPOINT_VALUES " != *" $CHECKPOINT "* ]]; then
    echo "Unknown checkpoint $CHECKPOINT in $ASSIGNMENT.java; should be one of $CHECKPOINT_VALUES"
    exit 1
  fi
fi

if cat $ASSIGNMENT.java | grep -q "ReadyForSubmission=YES"; then
  if [ $CHECKPOINTS == true ]; then
    echo "Submitting checkpoint $CHECKPOINT... please be patient"
    CHECKPOINT_PARAMETER="-F checkpoint=$CHECKPOINT"
  else
    echo "Submitting... please be patient"
    CHECKPOINT_PARAMETER=""
  fi
  curl -X POST \
       -H "Content-Type: multipart/form-data" \
       -F "codefile=@$ASSIGNMENT.java" \
       $CHECKPOINT_PARAMETER \
       $SUBMISSION_URL
else
  javac $ASSIGNMENT.java && java $ASSIGNMENT
fi
