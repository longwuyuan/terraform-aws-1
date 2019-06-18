# From https://techarena51.com/blog/flask-sqlalchemy-postgresql-tutorial/
from flask import render_template, request,flash, redirect, url_for
from model import Post, app

#READ
@app.route('/' )
def post_index():
    post = Post.query.all()
    return render_template('index.html', post=post)

#CREATE
@app.route('/add' , methods=['POST', 'GET'])
def post_add():
    if request.method == 'POST':
        post=Post(request.form['author'],request.form['title'],request.form['content'], request.form['published'])
        post_add=post.add(post)
    if not post_add:
        flash("Add was successful")
        return redirect(url_for('post_index'))
    else:
        error=post_add
        flash(error)
        return render_template('add.html')

#UPDATE
@app.route('/update/<id>' , methods=['POST', 'GET'])
def post_update (id):
    #Check if the post exists:
    post = Post.query.get(id)
    if post == None:
        flash("This entry does not exist in the database")
        return redirect(url_for('post_index'))
    if request.method == "POST":
        post.author=request.form['author']
        post.title = request.form['title']
        post.content = request.form['content']
        post.published=request.form['published']
        post_update=post.update()
        #If post.update does not return an error
        if not post_update:
            flash("Update was successful")
            return redirect(url_for('post_index'))
        else:
            error=post_update
            flash(error)
            return render_template('update.html', post=post)

#DELETE
@app.route('/delete/<id>' , methods=['POST', 'GET'])
def post_delete (id):
    post = Post.query.get(id)
    #Check if the post exists:
    if post == None:
        flash("This entry does not exist in the database")
        return redirect(url_for(post_index))
        post_delete=post.delete(post)
    if not post_delete:
        flash("Post was deleted successfully")
    else:
        error=post_delete
        flash(error)
        return redirect(url_for('post_index'))

    if __name__ == '__main__':
        app.debug=True
        app.run()
