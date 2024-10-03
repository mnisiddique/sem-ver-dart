import 'package:my_console_app/commit_source.dart';


void main(List<String> arguments) {
  final commitSrc = CommitSource();
  final commits = commitSrc.getCommits();
  commits.then((v) => print(v));
}


// Now we can run command in any style
// 1. Next we need to extract commit of the current branch
      // git reflog show <branch-name>

// 2. Next we need to extract commit of the current branch
// 3. Next we need to count feat, fix, breaking change
// 4. Next we need to get build number and version number from firebase and appstore and playstore.
// 5. Finally we need to calculate version and bump build number.
// dart run /Users/prince/Desktop/CalculatingSemVer/my_console_app/bin/my_console_app.dart 