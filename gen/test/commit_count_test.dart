import '../lib/commit_source.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group(
    'CommitCounter:',
    () {
      test('should detect breaking change', () {
        final commitCounter = CommitCounter(commits: ['']);
        expect(true, commitCounter.isBreakingChange('feat!'));
        expect(true, commitCounter.isBreakingChange('feat!:'));
        expect(true, commitCounter.isBreakingChange('feat!: ghedgh'));
        expect(true, commitCounter.isBreakingChange('fix!: ght'));
        expect(true, commitCounter.isBreakingChange('fix!'));
        expect(true, commitCounter.isBreakingChange('fix!:'));
        expect(true, commitCounter.isBreakingChange('!: ght'));
        expect(true, commitCounter.isBreakingChange('!'));
        expect(true, commitCounter.isBreakingChange('BREAKING CHANGE'));
        expect(true, commitCounter.isBreakingChange('BREAKING CHANGE:'));
        expect(true, commitCounter.isBreakingChange('BREAKING CHANGE: df'));
      });
      test('should detect feat change', () {
        final commitCounter = CommitCounter(commits: ['']);
        expect(true, commitCounter.isFeat('feat'));
        expect(true, commitCounter.isFeat('FEATURE'));
        expect(true, commitCounter.isFeat('feaT:'));
        expect(true, commitCounter.isFeat('FEAT'));
        expect(true, commitCounter.isFeat('feat: ghedgh'));
      });

      test('should detect fix change', () {
        final commitCounter = CommitCounter(commits: ['']);
        expect(true, commitCounter.isFix('fix'));
        expect(true, commitCounter.isFix('FIX'));
        expect(true, commitCounter.isFix('fix:'));
        expect(true, commitCounter.isFix('FIX:'));
        expect(true, commitCounter.isFix('fIx: ghedgh'));
        expect(true, commitCounter.isFix('FIX: ghedgh'));
      });
      test('should extract commit type', () {
        final commitCounter = CommitCounter(commits: ['']);
        expect("FIX FIX f", commitCounter.commitType('FIX FIX f: regex'));
        expect("Feat", commitCounter.commitType('Feat: adds sliver'));
        expect("fIx", commitCounter.commitType('fIx: ghedgh'));
        expect("BREAKING CHANGE",
            commitCounter.commitType('BREAKING CHANGE: ghedgh'));
        expect("!", commitCounter.commitType('!: ghedgh'));
      });

      test('should detect whether commit is conventional or not', () {
        final commitCounter = CommitCounter(commits: ['']);
        expect(true, commitCounter.isConventionalCommit('wip: My bad'));
        expect(true, commitCounter.isConventionalCommit('Feat: adds sliver'));
        expect(true, commitCounter.isConventionalCommit('fIx: ghedgh'));
        expect(true,
            commitCounter.isConventionalCommit('BREAKING CHANGE: ghedgh'));
        expect(true, commitCounter.isConventionalCommit('!: ghedgh'));
        expect(false, commitCounter.isConventionalCommit('cherry cherry lady'));
      });
      test(
        ' Should ignore non conventional commit',
        () {
          final commits = [
            'feat: Adds feature one',
            'feat: Adds feature two',
            'feat non conventional commit',
            'fix : fix count',
            'fix! : login',
          ];

          final expectedCount = CommitCount(
            featCount: 2,
            fixCount: 1,
            breakingChangeCount: 1,
          );

          final commitCounter = CommitCounter(commits: commits);
          final actualCount = commitCounter.count();
          expect(actualCount.featCount, expectedCount.featCount);
          expect(actualCount.fixCount, expectedCount.fixCount);
          expect(
            actualCount.breakingChangeCount,
            expectedCount.breakingChangeCount,
          );
        },
      );
    },
  );
}
