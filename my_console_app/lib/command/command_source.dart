part of './command.dart';

const kGetBranchName = Command(cmd: 'git rev-parse --abbrev-ref HEAD');

const kGetLatestTagFromMain = Command(cmd: 'git describe --tags --abbrev=0');

Command getCommitAfterTag(String tag) {
  return Command(cmd: 'git log --oneline ${tag.trim()}..HEAD');
}

Command getCommitFromBranch(String branchName) {
  return Command(cmd: 'git reflog show $branchName');
}
