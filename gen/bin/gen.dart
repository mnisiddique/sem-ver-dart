import 'package:gen/command/command.dart';
import 'package:gen/commit_source.dart';

import 'package:gen/gen.dart';

void main(List<String> arguments) async {
  if (arguments.first.trim() == 'build') {
    print(1);
    return;
  }
  final tag = await kGetLatestTagFromMain.run();
  final commitSrc = CommitSource(tag: tag);
  final commits = await commitSrc.getCommits();
  if (arguments.first.trim() == 'sem-ver') {
    final calculator = VersionCalculator(tag: tag, commits: commits);
    print(await calculator.calculate());
  } else if (arguments.first.trim() == 'release-note') {
    print(commits.join("\n"));
  } else {
    print('only sem-ver, build, release-note are valid parameters');
  }
}

/// 1. version
/// 2. release note
/// 3. build number
