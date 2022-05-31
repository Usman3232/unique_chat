import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uniqueeechat/ChatModule/Service/local_%20notification_handler.dart';
import 'package:uniqueeechat/ChatModule/ViewController/welcome_view_controller.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("message recieved");
//   print(message);
// If you're going to use other Firebase services in the background, such as Firestore,
// make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//
//   print("Handling a background message: ${message.messageId}");
//   await LocalNotifications().init();
//   LocalNotifications().notification('${message.notification!.title}',
//       '${message.notification!.body}', message.data.toString());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  // await LocalNotifications().init();
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  //
  // String? token = await messaging.getToken();
  // print('FCM TOKEN   ' + token.toString());

  // FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
  //   print("recieved");
  //   print(event.notification);
  //
  //   LocalNotifications().notification('${event.notification!.title}',
  //       '${event.notification!.body}', event.data.toString());
  // });

  // FirebaseMessaging.onMessageOpenedApp.listen((message) async {
  //   print("app is open  recieved");
  //   print(message.data);
  //   LocalNotifications().notification('${message.notification!.title}',
  //       '${message.notification!.body}', message.data.toString());
  // })
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:uniqueeechat/ChatModule/ViewController/welcome_view_controller.dart';
// void main(){
//   runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SplashScreen(),
//     );
//   }
// }
