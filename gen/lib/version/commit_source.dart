import '../command/command.dart';

final kCommitHashRegex = RegExp(r'\b[0-9a-f]{7,40}\b');

class CommitSource {
  final String tag;

  CommitSource({required this.tag});
  List<String> splitIntoList(String commitOutput) {
    return commitOutput.split('\n');
  }

  List<String> refineCommits(List<String> commits) {
    return commits
        .map((item) => item.replaceAll(kCommitHashRegex, ''))
        .toList();
  }

  Future<List<String>> getCommits() async {
    final branchName = await kGetBranchName.run();
    if (branchName.trim().contains('main')) {
      return refineCommits(splitIntoList(await getCommitAfter(tag).run()));
    }
    List<String> list =
        splitIntoList(await getCommitFromBranch(branchName).run());
    list = list.where((item) => item.trim().isNotEmpty).toList();
    final hash =
        kCommitHashRegex.allMatches(list[list.length - 1]).first.group(0);

    return refineCommits(splitIntoList(await getCommitAfter(hash!).run()));
  }
}

class CommitCounter {
  final List<String> commits;

  CommitCounter({required this.commits});

  bool isConventionalCommit(String commit) =>
      commit.startsWith(RegExp(r'[^:]+:'));
  bool isBreakingChange(String commitType) =>
      commitType.toLowerCase().contains('breaking change') ||
      RegExp(r'^(.*?)(!)').hasMatch(commitType);
  bool isFeat(String commitType) => commitType.toLowerCase().contains('feat');
  bool isFix(String commitType) => commitType.toLowerCase().contains('fix');
  String commitType(String commit) => commit.substring(0, commit.indexOf(':'));

  CommitCount count() {
    return commits.fold<CommitCount>(CommitCount.fromZero(),
        (prevCount, commit) {
      if (!isConventionalCommit(commit)) {
        return prevCount;
      }
      final type = commitType(commit);
      if (isBreakingChange(type)) {
        prevCount = prevCount.copyWith(
            breakingChangeCount: prevCount.breakingChangeCount + 1);
      } else if (isFeat(type)) {
        prevCount = prevCount.copyWith(featCount: prevCount.featCount + 1);
      } else if (isFix(type)) {
        prevCount = prevCount.copyWith(fixCount: prevCount.fixCount + 1);
      }

      return prevCount;
    });
  }
}

class CommitCount {
  final int featCount;
  final int fixCount;
  final int breakingChangeCount;

  CommitCount({
    required this.featCount,
    required this.fixCount,
    required this.breakingChangeCount,
  });

  factory CommitCount.fromZero() {
    return CommitCount(
      featCount: 0,
      fixCount: 0,
      breakingChangeCount: 0,
    );
  }

  CommitCount copyWith({
    int? featCount,
    int? fixCount,
    int? breakingChangeCount,
  }) {
    return CommitCount(
      featCount: featCount ?? this.featCount,
      fixCount: fixCount ?? this.fixCount,
      breakingChangeCount: breakingChangeCount ?? this.breakingChangeCount,
    );
  }

  @override
  String toString() {
    return "feat: $featCount\nfix: $fixCount\n brekChange: $breakingChangeCount";
  }
}
