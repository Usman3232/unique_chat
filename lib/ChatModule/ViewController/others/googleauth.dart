import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class MyHomePage extends StatelessWidget {
  TextEditingController test = TextEditingController();
  TextEditingController test2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          TextField(
            controller: test,
          ),
          TextField(
            controller: test2,
          ),
          IconButton(
              onPressed: () async {
                FirebaseFirestore.instance
                    .collection("UsmanData")
                    .add({"id": test.text, "name": test2.text});
              },
              icon: Icon(Icons.add)),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("UsmanData")
                  .snapshots(),
              builder: (context, snap) {
                return snap.connectionState == ConnectionState.waiting
                    ? const CircularProgressIndicator()
                    : ListView.builder(
                    itemCount: snap.data?.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) => Row(
                      children: [
                        Text(snap.data!.docs[index].get("name")),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              FirebaseFirestore.instance.collection("UsmanData").doc(snap.data!.docs[index].id).update({
                                "name":"xyz"
                              });
                            }, icon: Icon(Icons.edit)),
                        const Spacer(),
                        IconButton(
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection("UsmanData")
                                  .doc(snap.data!.docs[index].id)
                                  .delete();
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ));
              })
        ],
      ),
    );
  }
}
