from flask import Flask

app = Flask(__name__)

app.config['SECRET_KEY'] = 'your_secret_key_here'

# Import the routes blueprint and register it
from app.routes import routes_blueprint

app.register_blueprint(routes_blueprint)