part of 'command.dart';

const kGetBranchName = Command(cmd: 'git rev-parse --abbrev-ref HEAD');

const kGetLatestTagFromMain = Command(cmd: 'git describe --tags --abbrev=0');

Command getCommitAfter(String start) {
  return Command(cmd: 'git log --oneline ${start.trim()}..HEAD');
}

Command getCommitFromBranch(String branchName) {
  return Command(cmd: 'git reflog show $branchName');
}
