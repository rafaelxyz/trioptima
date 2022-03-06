# Instructions
* install docker and docker-compose
* cd trioptima/
## Start the message service
* docker-compose up --build
## Run some curl commands against the service
* ./test.sh

## Notes
* nginx, gunicorn for scalability
* check results in test.sh
* redis blocking/pipeline/monitor for concurrency
* json.dumps instead of two lists?

