import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uniqueeechat/ChatModule/Service/firebase_services.dart';
import 'package:uniqueeechat/ChatModule/Service/get_stoarage_handler.dart';
import 'package:uniqueeechat/ChatModule/ViewController/inbox_view_controller.dart';
import 'package:uniqueeechat/Utils/aut_btn.dart';
import 'package:uniqueeechat/ChatModule/Service/google_signin_service.dart';
import 'package:get/get.dart';

class ChatAuthViewController extends StatefulWidget {
  const ChatAuthViewController({Key? key}) : super(key: key);

  @override
  _ChatAuthViewControllerState createState() => _ChatAuthViewControllerState();
}

class _ChatAuthViewControllerState extends State<ChatAuthViewController> {
  final googleLoginVM = GoogleLoginService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.deepOrange, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/Logo1.png",
              ),
              Text(
                "Welcome to Google Sign ",
                style: TextStyle(
                    color: Colors.white,
                    height: 5,
                    fontWeight: FontWeight.bold,
                    fontSize: 31),
              ),
              Text(
                "Here is google 1 time Authentication",
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              Text(
                "You just have to click the google SignIn Button and Leave Everything to us and enjoy the amazing features of this application.....",
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              SizedBox(
                height: 50,
              ),
              CustomAuthButton(
                textcolour: Colors.white,
                height: 50,
                width: 150,
                colour: Colors.grey,
                title: "Google Sign In",
                callback: () async {
                  UserCredential userCredential =
                      await googleLoginVM.onGoogleSignIn();
                  googleLoginVM.onGoogleLogout();

                  if (userCredential != null) {
                    await saveUser(email: userCredential.user!.email!);
                    await GetStorageHandler()
                        .setEmail(userCredential.user!.email!);
                    Get.offAll(() => InboxViewController(
                          email: userCredential.user!.email!,
                        ));
                  }
                },
              ),
            ],
          ),
        ));
  }
}
