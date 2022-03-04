#!/bin/bash

# add and delete single messages
curl -w "\n" -d '{"user": "user1", "message": "hi1"}' -H "Content-Type: application/json" -X POST http://localhost:5000/
curl -w "\n" -d '{"user": "user1", "message": "hi2"}' -H "Content-Type: application/json" -X POST http://localhost:5000/

curl -w "\n" -d '{"user": "user1"}' -H "Content-Type: application/json" -X GET http://localhost:5000/

curl -w "\n" -d '{"user": "user1"}' -H "Content-Type: application/json" -X DELETE http://localhost:5000/
curl -w "\n" -d '{"user": "user1"}' -H "Content-Type: application/json" -X GET http://localhost:5000/
curl -w "\n" -d '{"user": "user1"}' -H "Content-Type: application/json" -X DELETE http://localhost:5000/
curl -w "\n" -d '{"user": "user1"}' -H "Content-Type: application/json" -X GET http://localhost:5000/

curl -w "\n" -d '{"user": "user2", "message": "hi1"}' -H "Content-Type: application/json" -X POST http://localhost:5000/
curl -w "\n" -d '{"user": "user2", "message": "hi2"}' -H "Content-Type: application/json" -X POST http://localhost:5000/


# delete several messages at in one call
curl -w "\n" -d '{"user": "user2"}' -H "Content-Type: application/json" -X GET http://localhost:5000/
curl -w "\n" -d '{"user": "user2", "count": 2}' -H "Content-Type: application/json" -X DELETE http://localhost:5000/
curl -w "\n" -d '{"user": "user2"}' -H "Content-Type: application/json" -X GET http://localhost:5000/

# unread messages
curl -w "\n" -d '{"user": "user3", "message": "hi1"}' -H "Content-Type: application/json" -X POST http://localhost:5000/
curl -w "\n" -d '{"user": "user3", "message": "hi2"}' -H "Content-Type: application/json" -X POST http://localhost:5000/
curl -w "\n" -d '{"user": "user3"}' -H "Content-Type: application/json" -X GET http://localhost:5000/unread
curl -w "\n" -d '{"user": "user3", "message": "hi3"}' -H "Content-Type: application/json" -X POST http://localhost:5000/
curl -w "\n" -d '{"user": "user3"}' -H "Content-Type: application/json" -X GET http://localhost:5000/unread


# delete all messages
curl -w "\n" -d '{"user": "user1", "count": 10}' -H "Content-Type: application/json" -X DELETE http://localhost:5000/
curl -w "\n" -d '{"user": "user2", "count": 10}' -H "Content-Type: application/json" -X DELETE http://localhost:5000/
curl -w "\n" -d '{"user": "user3", "count": 10}' -H "Content-Type: application/json" -X DELETE http://localhost:5000/
curl -w "\n" -d '{"user": "user4", "count": 10}' -H "Content-Type: application/json" -X DELETE http://localhost:5000/


# get all messages, should be empty
curl -w "\n" -d '{"user": "user1"}' -H "Content-Type: application/json" -X GET http://localhost:5000/
curl -w "\n" -d '{"user": "user2"}' -H "Content-Type: application/json" -X GET http://localhost:5000/
curl -w "\n" -d '{"user": "user3"}' -H "Content-Type: application/json" -X GET http://localhost:5000/
curl -w "\n" -d '{"user": "user4"}' -H "Content-Type: application/json" -X GET http://localhost:5000/
curl -w "\n" -d '{"user": "user4"}' -H "Content-Type: application/json" -X GET http://localhost:5000/unread
