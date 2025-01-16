import 'package:gen/cleaning/cleaner.dart';
import 'package:gen/command/command.dart';
import 'package:gen/version/commit_source.dart';

import 'package:gen/version/version_calculator.dart';
import 'package:gen/release_note/release_note_gen.dart';

void main(List<String> arguments) async {
  if (arguments.first.trim() == 'sem-ver') {
    calculateSemVer(arguments);
  } else if (arguments.first.trim() == 'release-note') {
    getReleaseNote(arguments);
  } else if (arguments.first.trim() == 'clean') {
    await cleaner.clean(arguments);
  } else if (arguments.first.trim() == 'verify-tag') {
    verifyTag(arguments);
  } else {
    print('only sem-ver, build, release-note are valid parameters');
  }
}

void getReleaseNote(List<String> arguments) async {
  final tag = await latestTag(arguments.length > 1 ? arguments[1] : null);
  final commitSrc = CommitSource(tag: tag);
  final commits = await commitSrc.getCommits();
  final releaseNote = ReleaseNoteGen(commits: commits);
  print(releaseNote.genReleaseNote(commitSrc.branchName));
}

void calculateSemVer(List<String> arguments) async {
  final tag = await latestTag(arguments.length > 1 ? arguments[1] : null);
  final commitSrc = CommitSource(tag: tag);
  final commits = await commitSrc.getCommits();
  final calculator = VersionCalculator(tag: tag, commits: commits);
  print(await calculator.calculate());
}

void verifyTag(List<String> arguments) async {
  const red = '\x1B[31m';
  const yellow = '\x1B[33m';
  const reset = '\x1B[0m';
  if (arguments.length < 2) {
    throw ArgumentError("$red No tag is given for verification $reset");
  }
  final tag = await latestTag(arguments.length > 2 ? arguments[2] : null);
  if (tag != null && !tag.contains(arguments[1])) {
    print("$yellow latest tag: $tag$reset");
    throw "$red Repository must have to be tagged with last released version. Either ${arguments[1]} is not latest or doesn't exist$reset";
  }
}

Future<String?> latestTag(String? prefix) async {
  try {
    final cmd = prefix == null
        ? kGetLatestTagFromMain
        : getLatestTagByMatchingPrefix("'$prefix*'");
    return await cmd.run();
  } catch (e) {
    return null;
  }
}
