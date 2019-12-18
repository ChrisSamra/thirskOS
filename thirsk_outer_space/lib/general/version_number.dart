/// This file is used to get info of the app, such as the version number or build number.

import 'dart:async';
import 'package:package_info/package_info.dart';
PackageInfo appInfo = PackageInfo();
Future<void> getAppInfo() async {
  final PackageInfo info = await PackageInfo.fromPlatform();
  appInfo = info;
}