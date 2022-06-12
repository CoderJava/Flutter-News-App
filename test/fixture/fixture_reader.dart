import 'dart:io';

String fixture(String name) {
  final currentDirectory = Directory.current.toString().replaceAll('\'', '');
  final lastDirectory = currentDirectory.split('/')[currentDirectory.split('/').length - 1];
  if (lastDirectory == 'test') {
    return File('fixture/$name').readAsStringSync();
  } else {
    return File('test/fixture/$name').readAsStringSync();
  }
}

File fromFile(String name) {
  final currentDirectory = Directory.current.toString().replaceAll('\'', '');
  final lastDirectory = currentDirectory.split('/')[currentDirectory.split('/').length - 1];
  if (lastDirectory == 'test') {
    return File('fixture/$name');
   } else {
    return File('test/fixture/$name');
  }
}