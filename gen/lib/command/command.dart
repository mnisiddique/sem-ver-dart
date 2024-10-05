import 'dart:io';
part 'command_source.dart';

class Command {
  final String _cmd;

  const Command({required String cmd}) : _cmd = cmd;

  Future<String> run() async {
    final runner = Platform.isWindows ? WindowsRunner() : UnixRunner();
    final result = await runner.run(_cmd);
    if (result.exitCode == 0) {
      return result.stdout.toString();
    }
    throw result.stderr;
  }
}

abstract class ProcessRunner {
  Future<ProcessResult> run(String cmd);
}

class WindowsRunner implements ProcessRunner {
  @override
  Future<ProcessResult> run(String cmd) async {
    return await Process.run('cmd', ['/c', cmd]);
  }
}

class UnixRunner implements ProcessRunner {
  @override
  Future<ProcessResult> run(String cmd) async {
    final String? shell = Platform.environment['SHELL'];
    if (shell != null && shell.contains('zsh')) {
      return await Process.run('zsh', ['-c', cmd]);
    }
    return await Process.run('bash', ['-c', cmd]);
  }
}
