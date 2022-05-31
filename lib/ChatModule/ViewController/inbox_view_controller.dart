import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uniqueeechat/ChatModule/Service/get_stoarage_handler.dart';
import 'package:uniqueeechat/ChatModule/Service/google_signin_service.dart';
import 'package:uniqueeechat/ChatModule/ViewController/add_user_modal.dart';
import 'package:uniqueeechat/ChatModule/ViewController/chat_screen.dart';
import 'package:uniqueeechat/ChatModule/ViewController/login_view.dart';
import 'package:uniqueeechat/ChatModule/ViewModel/inbox_view_model.dart';
import 'package:get/get.dart';

class InboxViewController extends StatefulWidget {
  final String email;

  InboxViewController({Key? key, required this.email}) : super(key: key);

  @override
  _InboxViewControllerState createState() => _InboxViewControllerState();
}

class _InboxViewControllerState extends State<InboxViewController> {
  final googleLoginVM = GoogleLoginService();
  final inBoxVM = Get.put(InboxViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inBoxVM.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("All User"),
            backgroundColor: Colors.deepOrange,
            actions: [
              InkWell(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    await GetStorageHandler().removeEmail();
                    Get.offAll(() => ChatAuthViewController());
                  },
                  child: Center(child: Text("LogOut"))),
              SizedBox(
                width: 20,
              ),
            ]),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              addUserModal(context);
            },
            tooltip: "Add User",
            child: Icon(Icons.add)),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Obx(() => ListView.builder(

              physics: BouncingScrollPhysics(),
                  itemCount: inBoxVM.users.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          Get.to(() =>
                              ChatScreenView(userEmail: inBoxVM.users[index]));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white54,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 5,
                                )
                              ],
                              borderRadius: BorderRadius.circular(25)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: Text(inBoxVM.users[index]),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ))));
  }
}
