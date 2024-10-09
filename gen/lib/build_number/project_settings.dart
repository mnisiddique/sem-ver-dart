import 'dart:convert';
import 'dart:io';

class ProjectSettings {
  final String privateKey;
  final String projectId;
  final Map<String, dynamic> appId;

  ProjectSettings({
    required this.privateKey,
    required this.projectId,
    required this.appId,
  });

  static Future<ProjectSettings> read() async {
    File settingsFile = File("project_settings.json");
    final map = json.decode(await settingsFile.readAsString());
    final saCredFile = File(map["firebaseSaCredentialPath"]);
    final saCredMap = json.decode(await saCredFile.readAsString());
    return ProjectSettings(
      privateKey: saCredMap["private_key"],
      projectId: map["projectId"],
      appId: map["appId"],
    );
  }

  @override
  String toString() {
    return "privateKey: $privateKey\nprojectId:$projectId\nappId:${appId.toString()}";
  }
}




/**{
    "firebase_sa_credential_path": "sa_credential.json",
    "projectId": "dhanvantariapp-f91c1",
    "appId": {
        "android": {
            "prod": "1:937682093465:android:83f8325ce5643536a47f08",
            "dev": "1:937682093465:android:71c4cc62fb83ebbaa47f08"
        },
        "ios": {
            "prod": "1:937682093465:ios:012f02892002d26fa47f08",
            "dev": "1:937682093465:ios:70923cb686e3abe9a47f08"
        }
    }
} */