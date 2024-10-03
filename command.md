## command to read commit from any repo
git --git-dir=/path/to/repo/.git log

```
import 'dart:io';

Future<void> main() async {
  // Specify the path to the repository
  String repoPath = '/path/to/your/repo/.git';

  // Run the git log command
  var result = await Process.run('git', ['--git-dir=$repoPath', 'log']);

  if (result.exitCode == 0) {
    print('Commits:\n${result.stdout}');
  } else {
    print('Error listing commits: ${result.stderr}');
  }
}
```