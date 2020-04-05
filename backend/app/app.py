# import the Flask class from the flask module
from flask import Flask, render_template
from flask import Flask, render_template, redirect, url_for, request , session , flash
# create the application object
app = Flask(__name__)

app.secret_key = "corona_v"

# ----------- welcome section --------------------- #
# use decorators to link the function to a url
@app.route('/')
def home():
    # return "Hello, World!"  # return a string
    return render_template('index.html')

@app.route('/welcome')
def welcome():
    return render_template('welcome.html')  # render a template


# --------------------  login \ logout  section ------------------#

# Route for handling the login page logic
@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        if request.form['username'] != 'admin' or request.form['password'] != 'admin':
            error = 'Invalid Credentials. Please try again.'
        else:
            session['logged_in'] = True
            flash('yot were just logged in ')
            return redirect(url_for('home'))
    return render_template('login.html', error=error)



@app.route('/logout')
def logout():
    session.pop('logged_in' , None)
    return redirect(url_for('welcome'))

# --------------------------

# @app.route('/api/v1/MedicalCentersNumOfPatients' , medthod = 'GET')
# def GetMedicalCentersNumOfPatients(medicalcenter_id , department_id , severity):
#     """
#     Get the number of patients by medical center
#     :param medicalcenter_id: str
#     :param department_id: str
#     :param severity: str
#     :return:   medicalcenterid , departmentid , severity,availablebeds , ,occupiedbeds ,
#     vacantbeds , insertdate ,updatedate ,iser ,breadingmachines.
#
#     """
#
#     pass




# start the server with the 'run()' method
if __name__ == '__main__':
    app.run(debug=True)