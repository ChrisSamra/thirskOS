import 'dart:async';
import 'package:package_info/package_info.dart';
PackageInfo appInfo = PackageInfo();
Future<void> getAppInfo() async {
  final PackageInfo info = await PackageInfo.fromPlatform();
  appInfo = info;
}