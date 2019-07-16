from sqlalchemy.orm import sessionmaker
from model import engine, Leaves, Employee, EmployeeDetails
from constants import *
from datetime import date

Session = sessionmaker(bind=engine)
db_session = Session()


def check_login(email, password):
    result = db_session.query(Employee).filter(email == Employee.email_id, password == Employee.password,
                                               Employee.status == EMPLOYEE_STATUS).first()
    if result:
        return True, result
    else:
        return False, 0


def get_total_approved_leaves(email_id):
    try:
        emp = get_id(email_id)
        leaves = db_session.query(Leaves).filter(Leaves.employee_id == emp.employee_id).all()
        count_result = db_session.query(Leaves).filter(Leaves.employee_id == emp.employee_id,
                                                       Leaves.status == APPROVED).all()
        count = len(count_result)
        return leaves, count
    except:
        db_session.close()


def add_leave(_id, _type, leave_date, reason):
    query = Leaves(employee_id=_id, leave_date=leave_date, leave_type=_type, apply_date=date.today(),
                   status=STATUS, apply_reason=reason, reason="")
    db_session.add(query)
    db_session.commit()
    return True


def get_total_leaves():
    data = db_session.query(Leaves, EmployeeDetails).join(EmployeeDetails,
                                                          (EmployeeDetails.employee_id == Leaves.employee_id)).all()
    return data


def get_user(email):
    emp = get_id(email)
    user = db_session.query(EmployeeDetails).filter(EmployeeDetails.employee_id == emp.employee_id).first()
    return True, user


def save_leave(_id, reason, status):
    db_session.query(Leaves).filter(Leaves.leave_id == _id).update({"reason": reason, "status": status})
    db_session.commit()
    return True


def get_id(email):
    user = db_session.query(Employee).filter(Employee.email_id == email).first()
    return user
