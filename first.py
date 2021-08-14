from datetime import date
from os import error, name
import os
from typing import ContextManager
from flask import Flask, render_template,request,session,redirect
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import json
from flask_mail import Mail
from werkzeug.utils import redirect, secure_filename
import math


with open('config.json', 'r') as c:
    params = json.load(c)["params"]

local_server = True

app = Flask(__name__)
app.config.update(
    MAIL_SERVER="smtp.gmail.com",
    MAIL_POR='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params["gmail_user"],
    MAIL_PASSWORD=params["gmail_password"],
)

app.config['UPLOAD_FOLDER'] = params['upload_location']

app.secret_key = 'the random string'

mail = Mail(app)

if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["local_uri"]
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["prod_uri"]
db = SQLAlchemy(app)


class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(20), unique=True, nullable=False)
    phone_num = db.Column(db.String(12), nullable=False)
    msg = db.Column(db.String(120), nullable=False)
    date = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)


class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    sub = db.Column(db.String(20), nullable=False)
    slug = db.Column(db.String(21), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    img_file = db.Column(db.String(12), nullable=False)
    date = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)


@app.route("/")
def home():
    posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts)/int(params['no_of_posts']))
    page = request.args.get('page')
    if (not str(page).isnumeric()):
        page = 1
    page = int(page)
    posts = posts[(page-1)*int(params['no_of_posts']):(page-1)*int(params['no_of_posts'])+ int(params['no_of_posts'])]
    if page==1:
        prev = "#"
        next = "/?page="+ str(page+1)
    elif page==last:
        prev = "/?page="+ str(page-1)
        next = "#"
    else:
        prev = "/?page="+ str(page-1)
        next = "/?page="+ str(page+1)
    
    return render_template('index.html', params=params, posts=posts, prev=prev, next=next)


@app.route('/about')
def about():
    return render_template('about.html', params=params)


@app.route('/contact', methods=['GET', 'POST'])
def contact():
    if request.method == 'POST':
        # add entry to the database

        name = request.form.get("name")
        email = request.form.get("email")
        phone_num = request.form.get("phone_num")
        msg = request.form.get("msg")

        entry = Contacts(name=name, email=email, phone_num=phone_num, msg=msg)
        db.session.add(entry)
        db.session.commit()
        mail.send_message('New message from ' + name, sender=email,
                          recipients=[params["recipient"]],
                          body=msg + "\n" + phone_num)

    return render_template('contact.html')


@app.route('/post/<string:posts_slug>', methods=['GET'])
def post_route(posts_slug):
    post = Posts.query.filter_by(slug=posts_slug).first()

    return render_template('post.html', post=post)

@app.route('/dashboard',methods=['GET', 'POST'])
def dashboard():
    if 'user' in session and session['user'] == params['admin_username']:
        posts = Posts.query.all()
        return render_template('dashboard.html', params = params,posts = posts)
    

    elif request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')

        if(username == params['admin_username'] and password == params['admin_password'] ):

            session['user'] = username
            posts = Posts.query.all() 
            return render_template('dashboard.html', params = params, posts = posts)

    return render_template('login.html')

@app.route('/edit/<string:sno>', methods=['GET', 'POST'])
def edit(sno):
    if 'user' in session and session['user'] == params['admin_username']:
        if request.method == 'POST':
            box_title = request.form.get('title')
            sub_title= request.form.get('sub_title')
            slug= request.form.get('slug')
            content= request.form.get('content')
            img_src= request.form.get('img_src')
            date = datetime.now()

            if sno == '0':
                post = Posts(title= box_title,sub = sub_title, slug= slug, content = content, img_file = img_src, date = date)
                db.session.add(post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(sno = sno).first()
                post.title = box_title
                post.sub = sub_title
                post.slug= slug
                post.content = content
                post.img_file = img_src
                db.session.commit()
                return redirect('/edit/'+sno)
        post = Posts.query.filter_by(sno = sno).first()
        return render_template('edit.html', params = params, post = post)

@app.route('/uploader',methods=['GET', 'POST'])
def uploader():
    if 'user' in session and session['user'] == params['admin_username']:
        if request.method == 'POST':
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'],secure_filename(f.filename) ))
            return "uploaded successfully"
    return redirect('/dashboard')

@app.route('/logout')
def logout():
    session.pop('user')
    return redirect('/dashboard')



@app.route('/delete/<string:sno>', methods=['GET', 'POST'])
def delete(sno):

    if 'user' in session and session['user'] == params['admin_username']:

        post = Posts.query.filter_by(sno = sno).first()
        db.session.delete(post)
        db.session.commit()

    return redirect('/dashboard')


if __name__ == '__main__':
    app.run(debug=True)
