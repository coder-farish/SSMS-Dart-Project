import 'dart:io';

int getIntInput(String prompt) {
  while (true) {
    print('\x1B[33m$prompt\x1B[0m');
    String? input = stdin.readLineSync();
    try {
      return int.parse(input!);
    } catch (e) {
      print('\x1B[31mInvalid input. Please enter a valid number.\x1B[0m');
    }
  }
}

String getStringInput(String prompt) {
  while (true) {
    print('\x1B[33m$prompt\x1B[0m');
    String? input = stdin.readLineSync();
    if (input != null && input.isNotEmpty) {
      return input;
    } else {
      print('\x1B[31mInvalid input. Please enter a non-empty value.\x1B[0m');
    }
  }
}

void clearConsole() {
  if (Platform.isWindows) {
    Process.runSync('cls', [], runInShell: true);
  } else {
    Process.runSync('clear', [], runInShell: true);
  }
}
