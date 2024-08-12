import 'dart:io';
import 'student.dart';

void saveRecord(String filePath, Student student) {
  var file = File(filePath);
  file.writeAsStringSync('${student}\n', mode: FileMode.append);
}

List<Student> loadRecords(String filePath) {
  var file = File(filePath);
  if (!file.existsSync()) {
    return [];
  }
  var lines = file.readAsLinesSync();
  return lines.map((line) => Student.fromString(line)).toList();
}

bool studentExists(String filePath, int rollNo) {
  List<Student> students = loadRecords(filePath);
  return students.any((student) => student.rollNo == rollNo);
}

void updateRecord(String filePath, Student updatedStudent) {
  List<Student> students = loadRecords(filePath);

  bool found = false;
  for (var i = 0; i < students.length; i++) {
    if (students[i].rollNo == updatedStudent.rollNo) {
      students[i] = updatedStudent;
      found = true;
      break;
    }
  }

  if (!found) {
    print(
        '\x1B[31mStudent with Roll No ${updatedStudent.rollNo} not found!\x1B[0m');
    return;
  }

  var file = File(filePath);
  file.writeAsStringSync('');

  for (var student in students) {
    file.writeAsStringSync('${student}\n', mode: FileMode.append);
  }
}

void deleteRecord(String filePath, int rollNo) {
  List<Student> students = loadRecords(filePath);
  students.removeWhere((student) => student.rollNo == rollNo);

  var file = File(filePath);
  file.writeAsStringSync('');

  for (var student in students) {
    file.writeAsStringSync('${student}\n', mode: FileMode.append);
  }
}
