from flask import Blueprint, jsonify

api = Blueprint('api', __name__, url_prefix='/api/v1')


@api.route('/')
def index():

    return jsonify(flag='success', msg='Hello world!')
