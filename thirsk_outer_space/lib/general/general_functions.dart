/// This file defines many functions and classes that are used throughout the application.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
///Link to a url. Opens as a web page for some reason.
Future launchURL(String url) async {
  if (await canLaunch(url)){
    await launch(url, forceSafariVC: true, forceWebView: false);
  } else {
    print("Fail to launch $url.");
  }

}
///A simple command to go to a page in the app.
void goToPage(BuildContext context,Widget page){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page), //goes to built in page when button pressed
  );
}
///Returns the minute value for [timeOfDay]
int timeOfDayToInt(TimeOfDay timeOfDay){
  return timeOfDay.hour * TimeOfDay.minutesPerHour + timeOfDay.minute;
}
/// Calculate the difference between [a] and [b].
///
/// If [a] is later than [b], the value is positive; otherwise, it's negative.
int timeOfDayDifference(TimeOfDay a, TimeOfDay b){
  return timeOfDayToInt(a) - timeOfDayToInt(b);
}

/// An interface for objects that can be cloned, either a shallow copy or a deep copy.
/// 
/// For some reason, flutter does not have this as one of its default functions.
abstract class Cloneable{
  /// Clones an object. Returns a new object with values identicle to the object that this is called on.
  /// 
  /// There are two types of cloning: shallow copying or deep copying.
  /// 
  /// * Shallow copying only copies reference to the fields of the original object, which means changing
  /// the field in the new object will change the field in the original object.
  /// * Deep copying makes new objects for the fields of th original object, making the original object
  /// and the new object completely independent.
  Object clone();
}

/// Retrieves data from a website and cache it in local files.
/// 
/// This class combines web data retrieving, and caching. Useful in areas such as the menu or the events
/// where the app will access information from the internet.
class DataRetriever {

  /// URL of the website to visit.
  final String websiteUrl;
  /// The location of the cache files, relative to the root folder of the temporary files of this app.
  final String cacheLocation;
  /// How long will the cached data be always retrieved rather than the web data since [_lastCached].
  /// 
  /// This function is added to save some mobile data, because the app won't be constantly trying to
  /// access the internet.
  /// 
  /// If null, this object will always try to retrieve data from the internet whenever possible.
  /// 
  /// Using the default constructor, null values will be automatically turned into the default
  /// 5 minute interval. To initialize this value as null, set `ignoreCacheUseDuration` to true in the
  /// constructor.
  Duration cacheUseDuration;
  /// The time since the cache data is last retrieved.
  DateTime _lastCached;
  /// Cache for the cache file. Save time, probably.
  String cachedData;
  /// The constructor for this class.
  /// 
  /// If [cacheUseDuration] is not specified, then a default 5 minutes is used.
  /// 
  /// Note: There is no direct way to set [cacheUseDuration] to null. To do so, set `ignoreCacheUseDuration`
  /// to true.
  DataRetriever(
    this.websiteUrl,
    this.cacheLocation,
    {
      this.cacheUseDuration,
      bool ignoreCacheUseDuration = false,
    }
  ) {
    if(cacheUseDuration == null && !ignoreCacheUseDuration){
      cacheUseDuration = Duration(minutes: 5);
    }
  }
  /// Get the temporary cache folder for this app.
  Future<String> get _localPath async {
    final directory = await getTemporaryDirectory();

    return directory.path;
  }
  /// Get the file location to store the cache data in.
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$cacheLocation');
  }
  /// Read the data from the cache file.
  /// 
  /// Returns the content when successfully retrieving the text. Otherwise, returns null.
  Future<String> readCacheData() async {
    if(cachedData != null)
      return cachedData;
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();
      _lastCached = await file.lastModified();
      cachedData = contents;
      return contents;
    } catch (e) {
      // If we encounter an error, return 0
      return null;
    }
  }
  /// Write [strToWrite] to the cache file.
  /// 
  /// Also updates [_lastCached] when writing data.
  Future<File> writeCacheData(String strToWrite) async {
    final file = await _localFile;
    _lastCached = DateTime.now();
    if(strToWrite != null)
      cachedData = strToWrite;
    file.setLastModified(_lastCached);
    // Write the file
    return file.writeAsString(strToWrite);
  }
  /// Read the data from [websiteUrl] directly.
  Future<http.Response> readWebData() async {
    try {
      return await http.get(websiteUrl);
    } catch(e) {
      return http.Response("",900);
    }
  }
  /// Retrieve the appropriate data.
  /// 
  /// There are two situations: directly reading from the cache file, or accessing the web first.
  /// 
  /// * If the time since the last cache is short enough(less than [cacheUseDuration]), there is no nead
  ///   for another visit to the website. Directly access the cache file and return any data retrieved
  ///   from there. This only happens when [forceRefresh] is set to false.
  /// * If the above does not apply, then first attempt to retrieve any data from the web.
  ///   * If successfully access the web, return that data and store the data in a cache file.
  ///   * If unsuccessfully access the web, return the cached data, if there is one.
  /// 
  /// For the return value:
  /// * If successfully executed, [http.Response.statusCode] should have a value of 200.
  /// * If the web is unsuccessfully accessed, [http.Response.statusCode] will have the error code, but
  ///   [http.Response.body] will have the cached data, if one existed.
  Future<http.Response> readData({bool forceRefresh = false}) async {
    if(forceRefresh || cacheUseDuration == null || _lastCached == null || DateTime.now().isAfter(_lastCached.add(cacheUseDuration))){
      // If the cache does not override the web data, under normal condition.
      final response = await readWebData();
      // 200 is the successful code when accessing data from a website.
      if(response.statusCode == 200){
        // If the response is successful, simply return the response and store the response as cache
        writeCacheData(response.body);
        return response;
      } else {
        // If the response is not successful, access the cache. This way the user can access previously
        // downloaded data without connecting to the internet.
        final cache = await readCacheData();
        return http.Response(cache,response.statusCode);
      }
    } else {
      // If the last time a new cache is made so close to the current time that another website visit
      // is unnecessary. This helps save the user's data theoretically.
      final cache = await readCacheData();
      return http.Response(cache,200);
    }
  }
}
/// A static class that stores some common colors in the app.
class ColorCoding{
  /// The color used for error messages.
  static final Color errorColor = Colors.redAccent[700];
  /// The color used for warning messages.
  static final Color warningColor = Colors.amber[800];
}
/// Returns `Theme.of(context).textTheme`.
TextTheme appTextTheme(BuildContext context){
  return Theme.of(context).textTheme;
}

Future<String> loadAsset(String path) async {
  return await rootBundle.loadString(path);
}