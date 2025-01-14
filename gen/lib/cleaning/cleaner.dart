import 'dart:io';

import 'package:gen/command/command.dart';

class Cleaner {
  Future<void> clean(List<String> args) async {
    List<String> paths = args.sublist(1);
    late Command cmd;
    if (Platform.isMacOS || Platform.isLinux) {
      cmd = Command(cmd: "rm -rf ${paths.join(' ')}");
    } else if (Platform.isWindows) {
      paths = paths.map((item) => '"$item"').toList();
      cmd = Command(cmd: "rmdir /s /q ${paths.join(' ')}");
    }
    // print(cmd.toString());
    cmd.run();
  }
}

Cleaner get cleaner => Cleaner();
