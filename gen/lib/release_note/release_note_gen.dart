class ReleaseNoteGen {
  final List<String> _commits;

  ReleaseNoteGen({required List<String> commits}) : _commits = commits;

  String genReleaseNote(String branchName) {
    int i = 0;
    final numberedCommits =
        _commits.where((item) => item.isNotEmpty).map((commit) {
      i = i + 1;
      final c = "$i. $commit";
      return c;
    });
    branchName = "\nBranch Name: $branchName\n";
    final note = numberedCommits.join('\n').trim();

    return branchName + note;
  }
}
