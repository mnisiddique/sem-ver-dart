import 'package:my_console_app/command/command.dart';

class CommitSource {
  List<String> processCommits(String commitOutput) {
    final list = commitOutput.split('\n');
    return list
        .map((item) => item.replaceAll(RegExp(r'\b[0-9a-f]{7,40}\b'), ''))
        .toList();
  }

  Future<List<String>> getCommits() async {
    final branchName = await kGetBranchName.run();
    if (branchName.trim().contains('main')) {
      final String tag = await kGetLatestTagFromMain.run();

      return processCommits(await getCommitAfterTag(tag).run());
    }
    return processCommits(await getCommitFromBranch(branchName).run());
  }
}
