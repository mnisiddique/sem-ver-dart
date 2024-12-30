import 'dart:io';

const String dstFileName = 'firebase.json';
void main(List<String> args) async {
  final srcName =
      args[0] == 'prod' ? 'firebase-prod.json' : 'firebase-dev.json';
  final rootProjectPath = await rootProject;
  final srcPath = buildPath(rootProjectPath, srcName, ['env']);
  final dstPath = buildPath(rootProjectPath, dstFileName, []);
  await deleteExistingFirebaseJson(rootProjectPath);
  final int exitCode = await copy(srcPath, dstPath);
  if (exitCode == 0) {
    print('$srcName copied into firebase.json successfully');
  }
}

String buildPath(String basePath, String filename, List<String> directories) {
  directories.join(Platform.pathSeparator);
  return '$basePath${Platform.pathSeparator}${directories.join(Platform.pathSeparator)}${Platform.pathSeparator}$filename';
}

Future<int> copy(String src, String dest) async {
  late ProcessResult pResult;
  if (Platform.isWindows) {
    pResult = await Process.run('copy', [src, dest]);
  } else {
    pResult = await Process.run('cp', ['-r', src, dest]);
  }
  return pResult.exitCode;
}

Future<String> get rootProject async {
  late ProcessResult pResult;
  if (Platform.isWindows) {
    pResult = await Process.run('echo', ['%cd%']);
  } else {
    pResult = await Process.run('pwd', []);
  }
  final rootProjectPath = pResult.stdout.toString().trim();
  return rootProjectPath;
}

Future<void> deleteExistingFirebaseJson(String rootProject) async {
  final path = buildPath(rootProject, dstFileName, []);
  if (Platform.isWindows) {
    await Process.run('del', [path]);
  } else {
    await Process.run('rm', [path]);
  }
}
