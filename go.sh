#!/bin/bash

ASSIGNMENT="ForLoopPractice"
SUBMISSION_URL="https://Project-Name.username.repl.co"

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

if cat $ASSIGNMENT.java | grep -q "ReadyForSubmission=YES"; then
  curl -X POST \
       -H "Content-Type: multipart/form-data" \
       -F "codefile=@$ASSIGNMENT.java" \
       $SUBMISSION_URL
else
  javac $ASSIGNMENT.java && java $ASSIGNMENT
fi
