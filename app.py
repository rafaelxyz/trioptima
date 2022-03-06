""" Service for sending and retrieving messages """
from flask import Flask, jsonify, request
from redis import Redis
from marshmallow import Schema, fields, ValidationError

flask = Flask(__name__)
redis = Redis(host='redis', port=6379, charset='utf-8', decode_responses=True)

class PostSchema(Schema):
    """ Verify incoming json data """
    user = fields.String(required=True)
    message = fields.String(required=True)

class GetSchema(Schema):
    """ Verify incoming json data """
    user = fields.String(required=True)

class DeleteSchema(Schema):
    """ Verify incoming json data """
    user = fields.String(required=True)
    count = fields.Integer(required=False)


@flask.route('/', methods=['POST'])
def post_message():
    """ Store incoming messages and the status of those messages. Stored in
        separate ordered lists. """

    data = request.get_json()
    schema = PostSchema()
    try:
        schema.load(data)
    except ValidationError as err:
        return jsonify(err.messages), 400

    user = data['user']
    msg = data['message']
    redis.lpush(user + ':message', msg)
    redis.lpush(user + ':unread', 'true')
    log_size(user)
    return 'Adding message, user: {}, message: {}'.format(user, msg), 201

@flask.route('/', methods=['GET'])
def get_messages():
    """ Return all messages for a user, even read messages """
    data = request.get_json()
    schema = GetSchema()
    try:
        schema.load(data)
    except ValidationError as err:
        return jsonify(err.messages), 400

    user = data['user']
    messages = redis.lrange(user + ':message', 0, -1)
    return 'Get messeges, user: {}, messages: {}'.format(user, messages)

@flask.route('/unread', methods=['GET'])
def get_unread_messages():
    """ Return all unread messages """
    data = request.get_json()
    schema = GetSchema()
    try:
        schema.load(data)
    except ValidationError as err:
        return jsonify(err.messages), 400

    user = data['user']
    result = []
    unread_list = redis.lrange(user + ':unread', 0, -1)
    for i, value in enumerate(unread_list):
        if value == 'true':
            result.append(redis.lindex(user + ':message', i))
            redis.lset(user + ':unread', i, 'false')
    return 'Get unread messages, user: {}, messages: {}'.format(user, result)

@flask.route('/', methods=['DELETE'])
def delete_messages():
    """ Delete messages, oldest first. Optional count """
    data = request.get_json()
    schema = DeleteSchema()
    try:
        schema.load(data)
    except ValidationError as err:
        return jsonify(err.messages), 400

    user = data['user']
    count = 1
    if 'count' in data:
        count = data['count']
    redis.rpop(user + ':message', count)
    redis.rpop(user + ':unread', count)
    log_size(user)
    return 'Deleted messages, user: {}, number of deleted messages: {}'.format(user, count)


def log_size(user):
    msg_length = redis.llen(user + ':message')
    unread_length = redis.llen(user + ':unread')
    flask.logger.info('message length:{}'.format(msg_length))
    flask.logger.info('unread length:{}'.format(unread_length))

if __name__ == "__main__":
    flask.run(host="0.0.0.0", debug=True)

