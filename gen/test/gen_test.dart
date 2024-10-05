import '../lib/version.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Version construction',
    () {
      test(
          'should construct [version] from any string that conatains [major.minor.patch] number',
          () {
        final list = [
          'v1.2.3-alpha',
          'v5.6.9-rc.1',
          'v3.6.7-beta',
          'v0.0.0',
          '1.2.3',
          'kfjgkjh1.2.3dh',
        ];

        final expectations = [
          '1.2.3',
          '5.6.9',
          '3.6.7',
          '0.0.0',
          '1.2.3',
          '1.2.3',
        ];
        final versions = list.map((elem) => Version.fromString(elem));

        int i = 0;
        for (final item in versions) {
          expect(item.toString(), expectations[i]);
          i = i + 1;
        }
      });
    },
  );

  
}
