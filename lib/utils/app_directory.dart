import 'dart:io';
import 'package:online_attendence_app/utils/permissions_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

getAppDirectory({image}) async {
  var directory;

  if (await requestPermission(Permission.storage)) {
    if (await requestPermission(Permission.manageExternalStorage)) {
      var tempDirectory = Directory(await _getPath());
      if (await tempDirectory.exists())
        // directory = Directory(await _getPath()).path;
        directory = tempDirectory.path;
      else
        directory = tempDirectory.create().then((value) => value.path);
    } else {
      // directory = Directory(await _getPath()).path;
      var tempDirectory = Directory(await _getPath());
      if (await tempDirectory.exists())
        directory = tempDirectory.path;
      else
        directory = tempDirectory.create().then((value) => value.path);
    }
  }

  return directory;
}

_getPath() async {
  var directory = (await getExternalStorageDirectory())!;
  String newPath = "";
  List<String> paths = directory.path.split("/");
  for (int x = 1; x < paths.length; x++) {
    String folder = paths[x];
    if (folder != "Android") {
      newPath += "/" + folder;
    } else {
      break;
    }
  }
  newPath = newPath + "/Attendance";

  return newPath;
}
