from sqlalchemy import create_engine, Column, MetaData, Integer, String, ForeignKey, DATE
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship

engine = create_engine('mysql://root:password@localhost/leave_management', echo=True)
meta = MetaData()
base = declarative_base()


class Role(base):
    __tablename__ = 'role'

    role_id = Column(Integer, primary_key=True, autoincrement=True)
    role_type = Column(String)


class Employee(base):
    __tablename__ = 'employee'

    employee_id = Column(Integer, primary_key=True, autoincrement=True)
    email_id = Column(String)
    password = Column(String)
    status = Column(String)
    created_date = Column(DATE)
    role_id = Column(Integer, ForeignKey('role.role_id'))
    role = relationship("Role")


class Address(base):
    __tablename__ = 'employee_address'

    id = Column(Integer, primary_key=True, autoincrement=True)
    street_address = Column(String)
    city = Column(String)
    state = Column(String)
    zip_code = Column(Integer)


class EmployeeDetails(base):
    __tablename__ = 'employee_profile'

    profile_id = Column(Integer, primary_key=True, autoincrement=True)
    employee_id = Column(Integer, ForeignKey('employee.employee_id'))
    first_name = Column(String)
    last_name = Column(String)
    dob = Column(DATE)
    phone_number = Column(String)
    doj = Column(DATE)
    qualification = Column(String)
    job_title = Column(String)
    gender = Column(String)
    employees = relationship("Employee")
    address = Column(Integer, ForeignKey('employee_address.id'))
    employee_address = relationship("Address")


class Leaves(base):
    __tablename__ = 'leaves'

    leave_id = Column(Integer, primary_key=True, autoincrement=True)
    employee_id = Column(Integer, ForeignKey('employee.employee_id'))
    leave_type = Column(String)
    leave_date = Column(DATE)
    apply_date = Column(DATE)
    status = Column(String)
    apply_reason = Column(String)
    reason = Column(String)
    employees = relationship("Employee")


base.metadata.create_all(engine)
