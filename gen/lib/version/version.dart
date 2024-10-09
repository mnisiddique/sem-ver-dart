final RegExp semverPattern = RegExp(r'(?<!\d)(0|[1-9][0-9]*)\.' // MAJOR
    r'(0|[1-9][0-9]*)\.' // MINOR
    r'(0|[1-9][0-9]*)' // PATCH

    );

class Version {
  final int major;
  final int minor;
  final int patch;

  const Version({
    required this.major,
    required this.minor,
    required this.patch,
  });

  factory Version.fromString(String versionString) {
    try {
      versionString = semverPattern.allMatches(versionString).first.group(0)!;
    } catch (e) {
      throw '[Version.fromString] Invalid version string';
    }

    final list = versionString.split('.');

    return Version(
      major: int.parse(list[0]),
      minor: int.parse(list[1]),
      patch: int.parse(list[2]),
    );
  }

  Version bumpMajor() {
    return Version(
      major: major + 1,
      minor: 0,
      patch: 0,
    );
  }

  Version bumpMinor() {
    return Version(
      major: major,
      minor: minor + 1,
      patch: 0,
    );
  }

  Version bumpPatch() {
    return Version(
      major: major,
      minor: minor,
      patch: patch + 1,
    );
  }

  @override
  String toString() {
    return "$major.$minor.$patch";
  }
}
