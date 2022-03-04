#!/bin/bash

# add and delete single messages
curl -w "\n" -d '{"user": "adam", "message": "hi1"}' -H "Content-Type: application/json" -X POST http://localhost:5000/
curl -w "\n" -d '{"user": "adam", "message": "hi2"}' -H "Content-Type: application/json" -X POST http://localhost:5000/

curl -w "\n" -d '{"user": "adam"}' -H "Content-Type: application/json" -X GET http://localhost:5000/

curl -w "\n" -d '{"user": "adam"}' -H "Content-Type: application/json" -X DELETE http://localhost:5000/
curl -w "\n" -d '{"user": "adam"}' -H "Content-Type: application/json" -X GET http://localhost:5000/
curl -w "\n" -d '{"user": "adam"}' -H "Content-Type: application/json" -X DELETE http://localhost:5000/
curl -w "\n" -d '{"user": "adam"}' -H "Content-Type: application/json" -X GET http://localhost:5000/

# delete several messages at in one call
curl -w "\n" -d '{"user": "bert", "message": "hi1"}' -H "Content-Type: application/json" -X POST http://localhost:5000/
curl -w "\n" -d '{"user": "bert", "message": "hi2"}' -H "Content-Type: application/json" -X POST http://localhost:5000/

curl -w "\n" -d '{"user": "bert"}' -H "Content-Type: application/json" -X GET http://localhost:5000/
curl -w "\n" -d '{"user": "bert", "count": 2}' -H "Content-Type: application/json" -X DELETE http://localhost:5000/
curl -w "\n" -d '{"user": "bert"}' -H "Content-Type: application/json" -X GET http://localhost:5000/

# unread messages
curl -w "\n" -d '{"user": "cecil", "message": "hi1"}' -H "Content-Type: application/json" -X POST http://localhost:5000/
curl -w "\n" -d '{"user": "cecil", "message": "hi2"}' -H "Content-Type: application/json" -X POST http://localhost:5000/
curl -w "\n" -d '{"user": "cecil"}' -H "Content-Type: application/json" -X GET http://localhost:5000/unread
curl -w "\n" -d '{"user": "cecil", "message": "hi3"}' -H "Content-Type: application/json" -X POST http://localhost:5000/
curl -w "\n" -d '{"user": "cecil"}' -H "Content-Type: application/json" -X GET http://localhost:5000/unread


# delete all messages
curl -w "\n" -d '{"user": "adam", "count": 10}' -H "Content-Type: application/json" -X DELETE http://localhost:5000/
curl -w "\n" -d '{"user": "bert", "count": 10}' -H "Content-Type: application/json" -X DELETE http://localhost:5000/
curl -w "\n" -d '{"user": "cecil", "count": 10}' -H "Content-Type: application/json" -X DELETE http://localhost:5000/

# bad json
curl -w "\n" -d '{"a": "adam", "msage": "i1"}' -H "Content-Type: application/json" -X POST http://localhost:5000/
curl -w "\n" -d '{"b": "bert"}' -H "Content-Type: application/json" -X DELETE http://localhost:5000/
curl -w "\n" -d '{"c": "adam"}' -H "Content-Type: application/json" -X GET http://localhost:5000/
curl -w "\n" -d '{"x": "bert"}' -H "Content-Type: application/json" -X GET http://localhost:5000/unread

# get all messages, should be empty
curl -w "\n" -d '{"user": "adam"}' -H "Content-Type: application/json" -X GET http://localhost:5000/
curl -w "\n" -d '{"user": "bert"}' -H "Content-Type: application/json" -X GET http://localhost:5000/
curl -w "\n" -d '{"user": "cecil"}' -H "Content-Type: application/json" -X GET http://localhost:5000/
curl -w "\n" -d '{"user": "adam"}' -H "Content-Type: application/json" -X GET http://localhost:5000/unread
curl -w "\n" -d '{"user": "bert"}' -H "Content-Type: application/json" -X GET http://localhost:5000/unread
curl -w "\n" -d '{"user": "cecil"}' -H "Content-Type: application/json" -X GET http://localhost:5000/unread
