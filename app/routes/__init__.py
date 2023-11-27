from flask import Blueprint

routes_blueprint = Blueprint("routes", __name__)

from app.routes import (
    dashboard,
    authentication,
    mypost,
    found,
    users,
    claimed,
    lost,
    unclaimed,
    landing,
    posts,
)

routes_blueprint.register_blueprint(dashboard.dashboard)
routes_blueprint.register_blueprint(authentication.authentication)
routes_blueprint.register_blueprint(mypost.mypost)
routes_blueprint.register_blueprint(found.found)
routes_blueprint.register_blueprint(users.users)
routes_blueprint.register_blueprint(claimed.claimed)
routes_blueprint.register_blueprint(lost.lost)
routes_blueprint.register_blueprint(unclaimed.unclaimed)
routes_blueprint.register_blueprint(landing.landing)
routes_blueprint.register_blueprint(posts.posts)
