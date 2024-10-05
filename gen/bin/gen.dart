import 'package:gen/command/command.dart';
import 'package:gen/commit_source.dart';

import 'package:gen/gen.dart';

Future<String> main(List<String> arguments) async {
  final tag = await kGetLatestTagFromMain.run();
  final commitSrc = CommitSource(tag: tag);
  final commits = await commitSrc.getCommits();
  final calculator = VersionCalculator(tag: tag, commits: commits);
  return await calculator.calculate();
}

/// 1. version
/// 2. release note
/// 3. build number
