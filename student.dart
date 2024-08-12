class Student {
  int rollNo;
  String studentName;
  String courseName;
  String classSchedule;

  Student(this.rollNo, this.studentName, this.courseName, this.classSchedule);

  @override
  String toString() {
    return '$rollNo,$studentName,$courseName,$classSchedule';
  }

  static Student fromString(String str) {
    var parts = str.split(',');
    return Student(int.parse(parts[0]), parts[1], parts[2], parts[3]);
  }
}

class User {
  String username;
  String password;
  String role;

  User(this.username, this.password, this.role);
}
