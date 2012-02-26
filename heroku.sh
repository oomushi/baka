#!/bin/bash
rake assets:precompile && git add public && git commit -m "pro heroku" && git push heroku master -f && git reset --hard HEAD^
