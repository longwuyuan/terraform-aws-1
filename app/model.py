# ./app/model.py
from flask import Flask
from flask.ext.sqlalchemy import SQLAlchemy
from sqlalchemy.sql.expression import text
from sqlalchemy.exc import SQLAlchemyError
from flask.ext.script import Manager
from flask.ext.migrate import Migrate, MigrateCommand

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI']= 'postgresql://pgdbuser:dummypass@dummyhost:5432/pgdb'
app.secret_key = 'some_secret'
db = SQLAlchemy(app)

#Create Database migrations
migrate = Migrate(app, db)
manager = Manager(app)
manager.add_command('db', MigrateCommand)

#Create the Post Class
class Post(db.Model):

    id = db.Column(db.Integer, primary_key=True)
    author = db.Column(db.String(255))
    title = db.Column(db.String(255),nullable=False)
    created_on=db.Column(db.TIMESTAMP,server_default=db.func.current_timestamp())
    content = db.Column(db.Text)
    published = db.Column(db.Boolean, server_default='True', nullable=False)

def __init__(self, author,title, content,published):
    self.author = author
    self.title = title
    self.content=content
    self.published=published

def add(self,post):
    db.session.add(post)
    return session_commit()

def update(self):
    return session_commit()

def delete(self,post):
    db.session.delete(post)
    return session_commit()

def session_commit():
    try:
        db.session.commit()
    except SQLAlchemyError as e:
        reason=str(e)

if __name__ == '__main__':
    manager.run()
