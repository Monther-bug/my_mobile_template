import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// App version information
class AppVersion {
  final String version;
  final int buildNumber;

  const AppVersion({required this.version, required this.buildNumber});

  /// Parse version string (e.g., "1.2.3")
  factory AppVersion.parse(String versionString, [int? build]) {
    return AppVersion(
      version: versionString,
      buildNumber: build ?? 0,
    );
  }

  /// Compare versions
  int compareTo(AppVersion other) {
    final thisParts = version.split('.').map(int.parse).toList();
    final otherParts = other.version.split('.').map(int.parse).toList();

    for (var i = 0; i < 3; i++) {
      final thisPart = i < thisParts.length ? thisParts[i] : 0;
      final otherPart = i < otherParts.length ? otherParts[i] : 0;

      if (thisPart > otherPart) return 1;
      if (thisPart < otherPart) return -1;
    }
    return 0;
  }

  bool operator <(AppVersion other) => compareTo(other) < 0;
  bool operator >(AppVersion other) => compareTo(other) > 0;
  bool operator <=(AppVersion other) => compareTo(other) <= 0;
  bool operator >=(AppVersion other) => compareTo(other) >= 0;

  @override
  String toString() => version;
}

/// Update status
enum UpdateStatus {
  upToDate,
  updateAvailable,
  forceUpdateRequired,
}

/// Update info from server
class UpdateInfo {
  final AppVersion latestVersion;
  final AppVersion minRequiredVersion;
  final String? releaseNotes;
  final String? downloadUrl;

  const UpdateInfo({
    required this.latestVersion,
    required this.minRequiredVersion,
    this.releaseNotes,
    this.downloadUrl,
  });

  factory UpdateInfo.fromJson(Map<String, dynamic> json) {
    return UpdateInfo(
      latestVersion: AppVersion.parse(json['latest_version'] as String),
      minRequiredVersion: AppVersion.parse(json['min_version'] as String),
      releaseNotes: json['release_notes'] as String?,
      downloadUrl: json['download_url'] as String?,
    );
  }
}

/// App update service
class AppUpdateService {
  AppUpdateService._();

  static Future<AppVersion> getCurrentVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return AppVersion(
      version: packageInfo.version,
      buildNumber: int.tryParse(packageInfo.buildNumber) ?? 0,
    );
  }

  /// Check update status
  static Future<UpdateStatus> checkUpdateStatus(UpdateInfo updateInfo) async {
    final currentVersion = await getCurrentVersion();

    if (currentVersion < updateInfo.minRequiredVersion) {
      return UpdateStatus.forceUpdateRequired;
    }

    if (currentVersion < updateInfo.latestVersion) {
      return UpdateStatus.updateAvailable;
    }

    return UpdateStatus.upToDate;
  }

  /// Show update dialog
  static Future<void> showUpdateDialog(
    BuildContext context, {
    required UpdateInfo updateInfo,
    required UpdateStatus status,
    VoidCallback? onUpdate,
    VoidCallback? onSkip,
  }) async {
    final isForceUpdate = status == UpdateStatus.forceUpdateRequired;

    return showDialog(
      context: context,
      barrierDismissible: !isForceUpdate,
      builder: (context) => AlertDialog(
        title: Text(isForceUpdate ? 'Update Required' : 'Update Available'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isForceUpdate
                  ? 'A new version is required to continue using the app.'
                  : 'A new version is available. Would you like to update?',
            ),
            if (updateInfo.releaseNotes != null) ...[
              const SizedBox(height: 16),
              const Text(
                'What\'s new:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(updateInfo.releaseNotes!),
            ],
          ],
        ),
        actions: [
          if (!isForceUpdate)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onSkip?.call();
              },
              child: const Text('Later'),
            ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onUpdate?.call();
            },
            child: const Text('Update Now'),
          ),
        ],
      ),
    );
  }
}
