import 'package:gen/build_number/project_settings.dart';

abstract class BuildNumber {
  Future<int> get();
}

class FirebaseBuildNumber implements BuildNumber {
  final ProjectSettings _settings;
  final List<String> _arguments;

  FirebaseBuildNumber({
    required ProjectSettings settings,
    required List<String> params,
  })  : _settings = settings,
        _arguments = params;

  String get platform {
    if (_arguments.length < 3) {
      throw 'platform not specified';
    }
    return _arguments[2];
  }

  String get flavor {
    if (_arguments.length < 4) {
      throw 'flavor not specified';
    }
    return _arguments[3];
  }

  String get appId {
    final value = _settings.appId[platform];
    String appId = '';
    if (value is String) {
      appId = value;
    } else {
      appId = value[flavor];
    }
    if (appId.isEmpty) {
      throw 'app id not found';
    }
    return appId;
  }

  @override
  Future<int> get() async {
    return 1;
  }
}
