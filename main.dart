import 'dart:io';
import 'student.dart';
import 'validations.dart';
import 'records.dart';

void mainMenu(User currentUser) {
  String filePath = 'studentsdb.txt';
  bool exit = false;

  while (!exit) {
    clearConsole();
    print('\x1B[36m');
    print('Welcome to the Saylani MassIT Student Management System!');
    print('--------------------------------------------------------');
    print('');
    print('1. Create Student Record');
    print('2. Retrieve All Student Records');
    print('3. Update Student Record');
    print('4. Delete Student Record');
    print('5. Logout');
    print('6. Exit');
    print('');
    print('Enter your choice: ');
    print('\x1B[0m');

    String? options = stdin.readLineSync();

    switch (options) {
      case '1':
        if (currentUser.role == 'Admin' || currentUser.role == 'Teacher') {
          while (true) {
            int rollNo = getIntInput('Enter Roll No:');
            if (studentExists(filePath, rollNo)) {
              print(
                  '\x1B[31mA student with Roll No $rollNo already exists!\x1B[0m');
            } else {
              String studentName = getStringInput('Enter Student Name:');
              String courseName = getStringInput('Enter Course Name:');
              String classSchedule = getStringInput('Enter Class Schedule:');

              var newStudent =
                  Student(rollNo, studentName, courseName, classSchedule);
              saveRecord(filePath, newStudent);
              print('\x1B[32mStudent record saved...\x1B[0m');
            }

            print('\x1B[35mDo you want to add more records? (y/n):\x1B[0m');
            String contOpt = stdin.readLineSync()!.toLowerCase();
            if (contOpt == 'n') {
              break;
            }
          }
        } else {
          print(
              '\x1B[31mYou do not have permission to perform this action.\x1B[0m');
        }
        break;

      case '2':
        List<Student> students = loadRecords(filePath);
        if (students.isEmpty) {
          print('\x1B[31mNo student records found.\x1B[0m');
        } else {
          print('\x1B[32mLoaded student records:\x1B[0m');
          for (var student in students) {
            print(
                '\x1B[32mRoll No: ${student.rollNo}, Student Name: ${student.studentName}, Course Name: ${student.courseName}, Class Timing: ${student.classSchedule}\x1B[0m');
          }
        }
        print('');
        sleep(Duration(seconds: 2));
        break;

      case '3':
        if (currentUser.role == 'Admin' || currentUser.role == 'Teacher') {
          while (true) {
            int rollNo = getIntInput('Enter Roll No of Student to update:');
            if (!studentExists(filePath, rollNo)) {
              print('\x1B[31mNo student with Roll No $rollNo found!\x1B[0m');
            } else {
              String studentName = getStringInput('Enter updated Name:');
              String courseName = getStringInput('Enter updated Course Name:');
              String classSchedule =
                  getStringInput('Enter updated Class Schedule:');

              var updatedStudent =
                  Student(rollNo, studentName, courseName, classSchedule);
              updateRecord(filePath, updatedStudent);
              print('\x1B[32mStudent record updated...\x1B[0m');
            }

            print('\x1B[35mDo you want to update more records? (y/n):\x1B[0m');
            String contOpt = stdin.readLineSync()!.toLowerCase();
            if (contOpt == 'n') {
              break;
            }
          }
        } else {
          print(
              '\x1B[31mYou do not have permission to perform this action.\x1B[0m');
        }
        break;

      case '4':
        if (currentUser.role == 'Admin') {
          while (true) {
            int rollNo = getIntInput('Enter Roll No of Student to delete:');
            if (!studentExists(filePath, rollNo)) {
              print('\x1B[31mNo student with Roll No $rollNo found!\x1B[0m');
            } else {
              deleteRecord(filePath, rollNo);
              print('\x1B[32mStudent record deleted...\x1B[0m');
            }

            print('\x1B[35mDo you want to delete more records? (y/n):\x1B[0m');
            String contOpt = stdin.readLineSync()!.toLowerCase();
            if (contOpt == 'n') {
              break;
            }
          }
        } else {
          print(
              '\x1B[31mYou do not have permission to perform this action.\x1B[0m');
        }
        break;

      case '5':
        print('\x1B[31mLogging out...\x1B[0m');
        login();
        return;

      case '6':
        print('\x1B[31mExiting...\x1B[0m');
        exit = true;
        break;

      default:
        print(
            '\x1B[31mInvalid choice. Please try again with the given choices.\x1B[0m');
        print('');
        break;
    }
  }
}

void login() {
  List<User> users = [
    User('admin', 'admin', 'Admin'),
    User('teacher', 'teacher', 'Teacher'),
    User('student', 'student', 'Student')
  ];

  while (true) {
    clearConsole();
    print('\x1B[36m');
    print('Saylani MassIT Student Management System Login');
    print('----------------------------------------------');
    print('');
    String username = getStringInput('Enter Username:');
    String password = getStringInput('Enter Password:');
    print('\x1B[0m');

    User? user = users.firstWhere(
        (user) => user.username == username && user.password == password,
        orElse: () => User('', '', ''));

    if (user.username.isNotEmpty) {
      print('\x1B[32mLogin successful. Welcome ${user.username}!\x1B[0m');
      sleep(Duration(seconds: 2));
      mainMenu(user);
      break;
    } else {
      print('\x1B[31mInvalid username or password. Please try again.\x1B[0m');
      sleep(Duration(seconds: 2));
    }
  }
}

void main() {
  login();
}
