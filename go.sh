#!/bin/bash

ASSIGNMENT=Addition

if cat $ASSIGNMENT.java | grep -q "ReadyForSubmission=YES"; then
  curl -X POST \
       -H "Content-Type: multipart/form-data" \
       -F "codefile=@$ASSIGNMENT.java" \
       http://localhost:8080/
else
  javac $ASSIGNMENT.java && java $ASSIGNMENT
fi
