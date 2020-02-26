import 'package:flutter/material.dart';
import 'package:thirsk_outer_space/general/common_widgets.dart';
import 'package:thirsk_outer_space/general/general_functions.dart';
import 'package:thirsk_outer_space/strings/string_getter.dart';
import 'package:thirsk_outer_space/general/version_number.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
/// A setting for the preference page.
abstract class PreferenceSetting {
  /// The name of the preference.
  String name;
  /// The tooltip for the preference.
  String tooltip;
  /// The identifier for the setting when used in JSON.
  String jsonIdentifier;
  /// Get the widget for this setting.
  Widget getSettingWidget();
}
class BooleanSetting extends PreferenceSetting {
  bool setting;

  @override
  Widget getSettingWidget() {
    // TODO: implement getSettingWidget
    throw UnimplementedError();
  }
}