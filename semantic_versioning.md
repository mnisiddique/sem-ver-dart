### From chatGPT
Calculating the semantic version of your Flutter app follows the principles of Semantic Versioning (SemVer), which typically uses a format like `MAJOR.MINOR.PATCH`. Here’s a breakdown of how to determine each part:

1. **MAJOR**: Increase this number when you make incompatible API changes. If your app introduces features or changes that break existing functionality, you need to bump the major version.

2. **MINOR**: Increment this number when you add functionality in a backward-compatible manner. If you introduce new features but maintain backward compatibility, you should increase the minor version.

3. **PATCH**: Increase this number when you make backward-compatible bug fixes. If you fix issues or make minor improvements that don’t change the functionality, bump the patch version.

### Steps to Calculate the Version:

1. **Identify Changes**:
   - List out the changes made since the last version.
   - Classify each change as a major, minor, or patch change.

2. **Bump the Version**:
   - If you have breaking changes, increment the MAJOR version and reset MINOR and PATCH to zero.
   - If you added new features but no breaking changes, increment the MINOR version and reset PATCH to zero.
   - If you made only bug fixes, increment the PATCH version.

3. **Example**:
   - Current version: `1.2.3`
     - If you add a new feature: New version should be `1.3.0`
     - If you fix a bug: New version should be `1.2.4`
     - If you introduce a breaking change: New version should be `2.0.0`

### Additional Considerations:

- **Pre-release Versions**: You can add labels like `-alpha`, `-beta`, or `-rc` (release candidate) to denote pre-release versions (e.g., `1.2.3-alpha`).
- **Build Metadata**: You can also add build metadata after a plus sign (e.g., `1.2.3+001`).

### Versioning Best Practices:

- **Keep a Changelog**: Document all changes and their classifications for clarity.
- **Consistency**: Be consistent with how you categorize changes to avoid confusion.
- **Communication**: Ensure that your team and users are aware of version changes and their implications.

By following these principles, you can effectively manage the semantic versioning of your Flutter app!

### What i understand
1. None of the number (major.minro.patch) incremented by number of features or fixes. They always incremented by one based on the feature/fix added no matter how many. per release they'll be incremented by 1.