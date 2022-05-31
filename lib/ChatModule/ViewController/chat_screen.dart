import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniqueeechat/ChatModule/Service/google_signin_service.dart';
import 'package:uniqueeechat/ChatModule/ViewModel/chat_view_model.dart';

class ChatScreenView extends StatefulWidget {
  final String userEmail;

  ChatScreenView({Key? key, required this.userEmail}) : super(key: key);

  @override
  _ChatScreenViewState createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> {
  final googleLoginVM = GoogleLoginService();
  final chatVM = ChatViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatVM.getMessages(userEmail: widget.userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(widget.userEmail),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Obx(() => Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: chatVM.messages.value.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment:
                                  chatVM.messages.value[index].email !=
                                          widget.userEmail
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width -
                                              70),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: chatVM.messages.value[index]
                                                    .email !=
                                                widget.userEmail
                                            ? Colors.deepOrange
                                            : Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            // blurRadius: 4,
                                            spreadRadius: 3,
                                          )
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child:Row(
                                        children: [
                                          Text(chatVM.messages[index].text +
                                              " " +
                                              "${DateFormat.EEEE().add_jm().format(DateTime.fromMillisecondsSinceEpoch(chatVM.messages[index].createdOn)).toUpperCase()}"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )),
                SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Type here",
                          ),
                          controller: chatVM.textController.value,
                        )),
                        IconButton(
                            onPressed: () async {
                              if (chatVM.textController.value.text.isNotEmpty) {
                                await chatVM.sendMessage(
                                    context: context,
                                    userEmail: widget.userEmail);
                              }
                            },
                            icon: Icon(Icons.send)),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
