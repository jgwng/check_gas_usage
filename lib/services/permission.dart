import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

Map<Permission, PermissionStatus> statuses;

checkInitPermissions() async {
  List<Permission> androidPermissions = [
    Permission.location,Permission.camera, Permission.storage, Permission.microphone
  ];
  List<Permission> iOSPermissions = [
    Permission.location,Permission.camera, Permission.photos, Permission.microphone
  ];

  if (Platform.isAndroid) {
    if(await Permission.storage.isUndetermined){
      statuses = await androidPermissions.request();
    }
  }
  else if(Platform.isIOS){
    if(await Permission.photos.isUndetermined){
      statuses = await iOSPermissions.request();
    }
  }
}

Future<bool> checkLocationPermissions() async {
  bool result = false;
  if (await Permission.location.request().isGranted) {
    result =  true;
  }else{
    await openAppSettings();
  }
  return result;
}


Future<bool> checkGalleryPermission() async{
  bool result = false;
    if(await Permission.storage.request().isGranted){
      result = true;
    } else
      await openAppSettings();

  return result;
}

  Future<bool> checkCameraPermission()async{
    List<Permission> androidPermissions = [Permission.camera, Permission.microphone, Permission.storage];
    List<Permission> iOSPermissions = [Permission.camera, Permission.microphone, Permission.photos];
    bool result = false;
    if(Platform.isAndroid){
      if(await Permission.camera.isUndetermined && await Permission.microphone.isUndetermined) {
        await androidPermissions.request();
       if(await Permission.camera.isGranted && await Permission.microphone.isGranted)
        result = true;
      }
      else if(await Permission.camera.isGranted && await Permission.microphone.isGranted)
        result = true;
      else
        await openAppSettings();
    }else if(Platform.isIOS){
      if(await Permission.camera.isUndetermined && await Permission.microphone.isUndetermined) {
        await iOSPermissions.request();
        if(await Permission.camera.isGranted && await Permission.microphone.isGranted)
          result = true;
      }
      else if(await Permission.camera.isGranted && await Permission.microphone.isGranted)
        result = true;
      else
        await openAppSettings();
    }
    return result;
  }