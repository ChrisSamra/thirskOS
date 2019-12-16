part 'string_definer.dart';
///Class for a dictionary of display string and ways to retrieve the string.
class DisplayString{
  Map<String,String> stringMap;
  DisplayString({this.stringMap});
  /// Gets the string from [stringAsset] based on the identifier.
  ///
  /// Example:
  ///
  /// ```
  /// getString('misc/loading'); //Will output 'Loading...' when stringAsset['misc/loading'] == 'Loading'
  /// ```
  ///
  /// Prints a warning if there is no entry for the identifier or the entry is blank.
  String getString(String identifier){
    if (stringMap.containsKey(identifier) && stringMap[identifier] != ''){
      return stringMap[identifier];
    } else{
      print('Warning: String for "' + identifier + '" is not defined');
      return identifier;
    }
  }
}

/// Gets the string from [stringAsset] based on the identifier.
///
/// Example:
/// ```dart
/// getString('misc/loading'); //Will output 'Loading...' when stringAsset['misc/loading'] == 'Loading'
/// ```
///
/// Prints a warning if there is no entry for the identifier or the entry is blank.
String getString(String identifier){
  return stringAsset.getString(identifier);
}
