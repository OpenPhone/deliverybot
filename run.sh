#!/usr/bin/env bash
if [ -f ".env" ]
then
   echo "source .env";
   source .env
fi

npx yarn start
