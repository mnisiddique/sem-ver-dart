import 'package:gen/build_number/build_number.dart';
import 'package:gen/build_number/project_settings.dart';
import 'package:gen/command/command.dart';
import 'package:gen/version/commit_source.dart';

import 'package:gen/version/version_calculator.dart';
import 'package:gen/release_note/release_note_gen.dart';

void main(List<String> arguments) async {
  if (arguments.first.trim().contains("build_number")) {
    final buildNumber = FirebaseBuildNumber(
      settings: await ProjectSettings.read(),
      params: arguments,
    );
    print(await buildNumber.get());
    return;
  }
  final tag = await latestTag;
  final commitSrc = CommitSource(tag: tag);
  final commits = await commitSrc.getCommits();
  print(commits);
  if (arguments.first.trim() == 'sem-ver') {
    final calculator = VersionCalculator(tag: tag, commits: commits);
    print(await calculator.calculate());
  } else if (arguments.first.trim() == 'release-note') {
    final releaseNote = ReleaseNoteGen(commits: commits);
    print(releaseNote.genReleaseNote());
  } else {
    print('only sem-ver, build, release-note are valid parameters');
  }
}

Future<String?> get latestTag async {
  try {
    return await kGetLatestTagFromMain.run();
  } catch (e) {
    return null;
  }
}
