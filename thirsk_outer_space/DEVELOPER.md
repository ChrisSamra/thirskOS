# Dev notice

If you are a developer, please attend the Thursday meetings after school. In addition, please join our discord server.

This application is developed using Flutter. More information for flutter can be found on <https://flutter.dev/>. It is encouraged for everyone who want to develop on the front end(the app itself) to learn flutter, especially if you want to work on the functionality of the app. For more information on the app, visit the GitHub repository and read the wiki that I wrote(shameless self-promotion time).

The GitHub repository for this app is <https://github.com/RageLeague/thirskOS>, but since you already read this, then you already know where the GitHub repo is.

If you intend to work on the backend of the app, go find Umut. He's the one dealing with all the backend stuff. The backend is in a seperate repository.

## Working on the front end of the app

If you are interested in working on the front end of this app, and already know how flutter works, then you need to know what specific functions that are added to help the development of this app. It is recommended to read the documentation for the various functions in the app.

You could read the source code if you want. It is most likely up to date with everything. However, if you want a cooler documentation, you can run `dartdoc` at `../thirsk_outer_space` in the command line(you have to add Dart SDK to the command line first. see "Command line using" below). It will generate a documentation file for this project. It is ignored in GitHub because there are too many files to track.

## Command line using

It is likely that you need to use command lines to simplify the process, and you likely need to use flutter commands in a regular console. To do that, you need to find the bin folder and add it to `PATH`. For Flutter, it is located at `(flutter)/bin`. The built in Dart SDK for flutter is located at `(flutter)/bin/cache/dart-sdk`, and you can add Dart SDK to your console by adding `(flutter)/bin/cache/dart-sdk/bin` to `PATH`.

### Adding commands to `PATH` in Windows

For Windows user, you can add commands such as `flutter` to `PATH` by do the following:

1. Search for `env` in the search bar to enter the "Edit The System Environment Variables" page.
2. Go to "Environmental Variables...".
3. Under "User Variables", if the variable `PATH`(ignore case) is not under it, add this variable and set the value to the bin folder for the command(such as `(flutter)/bin`). If the variable is already there, add the location of the bin to the list of paths already there. Seperate the paths using `;` if inputting the list of locations in one line.

Now you can use the command in any consoles! Providing you restart existing consoles, of course. Otherwise, the console would not register the changes.

## json_annotation and JSON parsing

To parse JSON strings, json_annotation is used. Some classes are marked as `@JsonSerializable()`, which means that this class can be parsed to and from JSON.

To generate JSON parsing logic once, run `flutter pub run build_runner build` at the root folder.

To generate JSON parsing logic continuously, run `flutter pub run build_runner watch` at the root folder.

More information, visit <https://flutter.dev/docs/development/data-and-backend/json>.
