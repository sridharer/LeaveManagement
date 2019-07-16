from flask import Flask, session, request, render_template, redirect, url_for
from mapper import *
from constants import TOTAL_LEAVES

app = Flask(__name__)


@app.route('/login', methods=['GET'])
@app.route('/', methods=['GET'])
def login():
    return render_template('login.html')


@app.route('/dashboard', methods=['POST', 'GET'])
def dashboard():
    if request.method == 'POST':
        email = request.form['username']
        session['user'] = email
        password = request.form['password']
        session['password'] = password
        flag, employee = check_login(email, password)

        if flag and employee.role.role_type == MANAGER:
            all_leaves = get_total_leaves()
            return render_template('manager_dashboard.html', leaves=all_leaves)

        if flag and employee.role.role_type == EMPLOYEE:
            leaves, count = get_total_approved_leaves(session['user'])
            left = TOTAL_LEAVES - count
            flag, profile = get_user(session['user'])
            return render_template('employee_dashboard.html', rem_leaves=left, leaves_used=count,
                                   leaves=leaves, _id=employee.employee_id, profile=profile)

        else:
            error = 'Invalid username or password. Please try again!'
            return render_template('login.html', error=error)

    else:
        flag, user = check_login(session['user'], session['password'])

        if flag and user.role.role_type == MANAGER:
            all_leaves = get_total_leaves()
            return render_template('manager_dashboard.html', leaves=all_leaves)

        if flag and user.role.role_type == EMPLOYEE:
            leaves, count = get_total_approved_leaves(session['user'])
            left = TOTAL_LEAVES - count
            flag, profile = get_user(session['user'])
            return render_template('employee_dashboard.html', rem_leaves=left, leaves_used=count,
                                   leaves=leaves, profile=profile)


@app.route('/new_leave', methods=['GET', 'POST'])
def new_leave():
    if request.method == 'POST':
        leave_date = request.form['leave_date']
        reason = request.form['apply_reason']
        _type = request.form['types']
        _id = request.form['employee_id']

        flag = add_leave(_id, _type, leave_date, reason)
        if flag:
            return redirect(url_for('dashboard'))
        else:
            error = 'Invalid data. Please try again!'
            return render_template('leave.html', error=error)
    else:
        employee = get_id(session['user'])
        return render_template('leave.html', _id=employee.employee_id)


@app.route('/save-<int:_id>', methods=['GET', 'POST'])
def save(_id):
    reason = request.form['reason']
    status = request.form['status']

    flag = save_leave(_id, reason, status)

    if flag:
        return redirect(url_for('dashboard'))
    else:
        error = 'Error Occured While Applying Leave!!'
        return redirect(url_for('dashboard', error=error))


@app.route('/logout', methods=['POST'])
def logout():
    print(session.pop('user', None))
    return redirect(url_for('login'))


if __name__ == "__main__":
    app.secret_key = 'securitykey'
    app.run(debug=True)
