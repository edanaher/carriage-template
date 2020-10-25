#!/bin/bash

if cat ForLoopPractice.java | grep -q "ReadyForSubmission=YES"; then
  curl -X POST \
       -H "Content-Type: multipart/form-data" \
       -F "codefile=@ForLoopPractice.java" \
       https://Loop120-Grading-Server.latinacadcs.repl.co
else
  javac ForLoopPractice.java
  java ForLoopPractice
fi