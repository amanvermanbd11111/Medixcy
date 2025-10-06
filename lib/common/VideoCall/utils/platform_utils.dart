
import 'package:flutter/foundation.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_io/io.dart';


Future<bool> stopBackgroundExecution() async {
  if (Platform.isAndroid && FlutterBackground.isBackgroundExecutionEnabled) {
    return FlutterBackground.disableBackgroundExecution();
  } else {
    return Future.value(true);
  }
}

Future<bool> hasBackgroundExecutionPermissions() async {
  if (Platform.isAndroid) {
    return FlutterBackground.hasPermissions;
  } else {
    return Future.value(true);
  }
}

Future<void> checkSystemAlertWindowPermission() async {
  // if (Platform.isAndroid) {
  //   var androidInfo = await DeviceInfoPlugin().androidInfo;
  //   var sdkInt = androidInfo.version.sdkInt;
  //
  //   if (sdkInt >= 31) {
  //     if (await Permission.systemAlertWindow.isDenied) {
  //       Get.dialog(AlertDialog(
  //         title: Text('call_accept_title'.tr),
  //         content: Text('call_accept_subtitle'.tr),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Permission.systemAlertWindow.request().then((status) {
  //                 if (status.isGranted) {
  //                   Get.back();
  //                 }
  //               });
  //             },
  //             child: const Text(
  //               'Allow',
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Get.back();
  //             },
  //             child: const Text(
  //               'Later',
  //             ),
  //           ),
  //         ],
  //       ));
  //     }
  //   }
  // }
}

requestNotificationsPermission() async {
  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS || Platform.isWindows)) {
    var isPermissionGranted = await Permission.notification.isGranted;
    if (!isPermissionGranted) {
      await Permission.notification.request();
    }
  }
}
