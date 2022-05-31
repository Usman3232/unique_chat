import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uniqueeechat/ChatModule/Service/get_stoarage_handler.dart';
import 'package:uniqueeechat/ChatModule/ViewController/inbox_view_controller.dart';
import 'package:uniqueeechat/ChatModule/ViewController/login_view.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkUser();
    });
  }

  checkUser() async {
    final email = await GetStorageHandler().getEmail();
    if (email != null) {
      Get.offAll(() => InboxViewController(
            email: email,
          ));
    } else {
      Get.offAll(() => ChatAuthViewController());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepOrange,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black, Colors.deepOrange, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/Logo1.png",
              ),
              SizedBox(
                height: 30,
              ),
              const CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
