from flask import Flask, render_template, request, session, redirect, flash
from flask_sqlalchemy import SQLAlchemy
import json
from flask_mail import Mail
from datetime import datetime
import os
from werkzeug.utils import secure_filename
import math

with open('config.json', 'r') as c:
    params = json.load(c) ["params"]

local_server = True
app = Flask(__name__)
app.secret_key = 'super-secret-key'
app.config['UPLOAD_FOLDER'] = params['upload_location']

app.config.update(
    MAIL_SERVER = "smtp.gmail.com",
    MAIL_PORT = "465",
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params["gmail-user"],
    MAIL_PASSWORD = params["gmail-password"]
)
mail = Mail(app)

if(local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params["local_uri"]
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["prod_uri"]

db = SQLAlchemy(app)                                                      # ye humne db var ko initialise kar diya

class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(20), nullable=False)
    phn_num = db.Column(db.String(12), nullable=False)
    msg = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)

class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(21), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    img_file = db.Column(db.String(30), nullable=True)
    tagline = db.Column(db.String(100), nullable=False)

@app.route("/")
def home():
    # flash("Hello People!", "success" )
    # flash("Follow me on Linkdin for better reach", "danger")

    posts = Posts.query.filter_by().all()
    # [0: params['no_of_posts']]
    last = math.ceil( len(posts)/ int(params['no_of_posts']) )

    page = request.args.get('page')                                # ek get request marenge
    if (not str(page).isnumeric()):                                # Hum check karenge ki jo page hai wo numeric hai ki ni
        page = 1                                                   # Initially khi ni hai to first page me hona chahiye
    page = int(page)                                               # Later for calculations, we want page as an integer

    posts = posts[ (page-1)*int(params['no_of_posts']) : (page-1)*int(params['no_of_posts']) + int(params['no_of_posts']) ]      # posts slicing

    if (page==1):
        prev = "#"
        next = "/?page=" + str(page+1)
    elif (page==last):
        prev = "/?page=" + str(page-1)
        next = "#"
    else:
        prev = "/?page=" + str(page-1)
        next = "/?page=" + str(page+1)

    return render_template("index.html", params=params, posts=posts, prev=prev, next=next)


@app.route("/about")
def about():
    return render_template("about.html", params=params)

@app.route("/dashboard", methods = ['GET', 'POST'])
def dashboard():
    if ('user' in session and session['user'] ==  params['admin_user']):
        posts = Posts.query.all()
        return render_template('dashboard.html', params=params, posts=posts)

    if request.method=="POST":
        '''REDIRECT TO ADMIN PANEL'''
        username = request.form.get('uname')
        userpass = request.form.get('pass')
        if (username == params['admin_user'] and userpass == params['admin_password']):
            ''' set the session variable'''
            session['user'] = username                                    # hum bata rhe ki ye user session me logged in hai
            posts = Posts.query.all()
            return render_template('dashboard.html', params=params, posts=posts)
    return render_template("login.html", params=params)


@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=params, post=post)


@app.route("/edit/<string:sno>", methods = ['GET', 'POST'])
def edit(sno):
    if ('user' in session and session['user'] == params['admin_user']):
        if request.method == 'POST':
            box_title = request.form.get('title')
            tline = request.form.get('tline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            date = datetime.now()

            if sno=='0':
                post = Posts(title=box_title, slug=slug, content=content, tagline=tline, img_file=img_file, date=date)
                db.session.add(post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(sno=sno).first()
                post.title = box_title
                post.slug = slug
                post.content = content
                post.tagline = tline
                post.img_file = img_file
                post.date = date
                db.session.commit()
                return redirect('/edit/'+sno)
        post = Posts.query.filter_by(sno=sno).first()
        return render_template('edit.html', params=params, post=post, sno=sno)


@app.route("/uploader", methods = ['GET', 'POST'])
def uploader():
    if ('user' in session and session['user'] == params['admin_user']):
        if request.method == 'POST':
            f = request.files['file1']                                                           # file ko leke save kar denge ond os module ki help se os module ke methods ko use kar skate hai
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename) ))      # Folder ko file ke name se join kar denge
            return "Uploaded Successfully"


@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/dashboard')

@app.route("/delete/<string:sno>", methods = ['GET', 'POST'])
def delete(sno):
    if ('user' in session and session['user'] == params['admin_user']):
        post = Posts.query.filter_by(sno=sno).first()                              # .first() is used because we want that first post aye and not the list.
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')


@app.route("/contact", methods = ['GET', 'POST'])
def contact():
    if(request.method == 'POST'):
        name = request.form.get('name')                                   # Adding entry to the database -> Firstly Fetching Then Adding
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')

        entry = Contacts(name=name, phn_num=phone, msg=message, email=email, date=datetime.now() )
        db.session.add(entry)
        db.session.commit()

        # mail.send_message('New message from '+ name, sender=email, recipients = [params['gmail-user']], body = message + '\n' + phone)
        flash("Your message has been submitted. We will get back to you soon.", "success")

    return render_template("contact.html", params=params)

app.run(debug=True)

