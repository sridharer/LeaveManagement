# LeaveManagement

# Create MySQL Database

Database Name : leave_management

User Name : root

Password : password

In model.py you can find a line with mysql db details, 
engine = create_engine('mysql://root:password@localhost/leave_management', echo=True)
Here root id the username and password is password.

Dump leave_management.sql file into your mysql workbench with database name as leave_management.

I have used 5 tables here:

1. Employee
2. Employee Profile
3. Employee Address
4. Role
5. Leaves

# About the Application

1. Login : Based on the Role of that user, he will be logged in either as a employee or manager. You can find the credentials in the leave_management.sql file.
  
2. Employee have flexibility to apply 21 leaves a year, each leave at one and if he exceeds all 21, then he cannnot apply any more leaves. When employee applys for a leave, the status would be pending till the manager approves or rejects it. Employee can view the history of his applied leaves and also his profile. 
   
3. Manager can view all the employee leaves and change the status to either approve or reject with a reason. 
