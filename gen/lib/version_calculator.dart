import 'package:gen/commit_source.dart';
import 'package:gen/version.dart';

class VersionCalculator {
  final String tag;
  final List<String> commits;

  VersionCalculator({
    required this.tag,
    required this.commits,
  });

  Future<String> calculate() async {
    Version version = Version.fromString(tag);
    final commitCounter = CommitCounter(commits: commits);
    final commitCount = commitCounter.count();
    if (commitCount.breakingChangeCount > 0) {
      version = version.bumpMajor();
    } else if (commitCount.featCount > 0) {
      version = version.bumpMinor();
    } else if (commitCount.fixCount > 0) {
      version = version.bumpPatch();
    }
    return version.toString();
  }
}
