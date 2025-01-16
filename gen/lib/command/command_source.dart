part of 'command.dart';

const kGetBranchName = Command(cmd: 'git rev-parse --abbrev-ref HEAD');

const kGetLatestTagFromMain =
    Command(cmd: 'git tag --list --merged main | sort -V | tail -n 1');

Command getCommitAfter(String start) {
  return Command(cmd: 'git log --oneline ${start.trim()}..HEAD');
}

Command getLatestTagByMatchingPrefix(String prefix) {
  return Command(
      cmd: 'git tag --list $prefix --merged main | sort -V | tail -n 1');
}

Command getCommitFromBranch(String branchName) {
  return Command(cmd: 'git reflog show $branchName');
}

Command getAllCommit() {
  return Command(cmd: 'git log --oneline');
}
