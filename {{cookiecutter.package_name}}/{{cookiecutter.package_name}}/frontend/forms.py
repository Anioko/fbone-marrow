from flask.ext.wtf import Form
from wtforms import HiddenField, BooleanField, TextField, PasswordField, SubmitField
from wtforms.validators import Required


class LoginForm(Form):

    next = HiddenField()
    login = TextField(u'Username or email', [Required()])
    password = PasswordField('Password', [Required()])
    remember = BooleanField('Remember me')
    submit = SubmitField('Sign in')
