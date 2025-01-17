#!/usr/bin/python3
""" Starts Flask Web Application C is fun """

from flask import Flask
app = Flask(__name__)


@app.route('/')
def hello_hbnb():
    """ Returns string when / is called """
    return 'Hello HBNB!'


@app.route('/hbnb')
def hbnb():
    """ Returns a string when /hbnb is called """
    return 'HBNB'


@app.route('/c/<text>')
def c_is_fun(text):
    """ Returns a reformatted text when /c is called """
    return 'C ' + text.replace('_', ' ')

if __name__ == '__main__':
    app.url_map.strict_slashes = False
    app.run(host='0.0.0.0', port=5000)
