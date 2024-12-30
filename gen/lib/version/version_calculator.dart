import 'package:gen/version/commit_source.dart';
import 'package:gen/version/version.dart';

class VersionCalculator {
  final String? tag;
  final List<String> commits;

  VersionCalculator({
    this.tag,
    required this.commits,
  });

  Future<String> calculate() async {
    if (tag == null) {
      return Version.fromString("v1.0.0").toString();
    }
    Version version = Version.fromString(tag!);
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
