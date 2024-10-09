import 'package:gen/version/version_calculator.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('VersionCalculator', () {
    test('should not bump version if no [feat] [fix] [BREAKING CHANGE]',
        () async {
      final commits = [
        "wip: adding something",
        "chore: deletes imports",
        "refactor: jwt decoding",
      ];
      final calculator =
          VersionCalculator(tag: "v1.0.0-alpha", commits: commits);
      final version = await calculator.calculate();
      expect("1.0.0", version);
    });
  });

  test('Breaking change is taking priority over all', () async {
    final commits1 = [
      "feat: adding something",
      "fix: deletes imports",
      "BREAKING CHANGE: jwt decoding",
    ];
    final commits2 = [
      "feat: adding something",
      "fix: deletes imports",
      "feat!: jwt decoding",
    ];
    final commits3 = [
      "feat: adding something",
      "fix: deletes imports",
      "!: jwt decoding",
    ];
    final calculator =
        VersionCalculator(tag: "v1.0.0-alpha", commits: commits1);
    final version = await calculator.calculate();
    expect("2.0.0", version);
    final calculator2 =
        VersionCalculator(tag: "v1.0.0-alpha", commits: commits2);
    final version2 = await calculator2.calculate();
    expect("2.0.0", version2);
    final calculator3 =
        VersionCalculator(tag: "v1.0.0-alpha", commits: commits3);
    final version3 = await calculator3.calculate();
    expect("2.0.0", version3);
  });
  test('feat is taking priority over fix', () async {
    final commits1 = [
      "feat: adding something1",
      "feat: adding something2",
      "fix: deletes imports1",
      "fix: deletes imports2",
      "fix: deletes import3",
    ];

    final calculator =
        VersionCalculator(tag: "v1.0.0-alpha", commits: commits1);
    final version = await calculator.calculate();
    expect("1.1.0", version);
  });

  test('fix is bumping only patch', () async {
    final commits1 = [
      "fix: deletes imports1",
      "fix: deletes imports2",
      "fix: deletes import3",
    ];

    final calculator =
        VersionCalculator(tag: "v1.0.0-alpha", commits: commits1);
    final version = await calculator.calculate();
    expect("1.0.1", version);
  });
  test(
      'should bump major version only once no matter how many breaking changes are introduced',
      () async {
    final commits = [
      "feat: adding something",
      "fix: deletes imports",
      "BREAKING CHANGE: jwt decoding",
      "BREAKING CHANGE: jwt decoding 2",
    ];
    final calculator = VersionCalculator(tag: "v1.0.0-alpha", commits: commits);
    final version = await calculator.calculate();
    expect("2.0.0", version);

    final commits1 = [...commits, 'BREAKING CHANGE: jwt decoding 3'];
    final calculator1 =
        VersionCalculator(tag: "v1.0.0-alpha", commits: commits1);
    final version1 = await calculator1.calculate();
    expect("2.0.0", version1);
  });
}