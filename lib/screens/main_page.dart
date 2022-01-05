import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_webapp/constants/constants.dart';
import 'package:diary_webapp/model/user.dart';
import 'package:diary_webapp/screens/login_page.dart';
import 'package:diary_webapp/widgets/create_profile.dart';
import 'package:diary_webapp/widgets/create_profile_alert_dialogue.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? _dropDownText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: kTeal100Color, //change your color here
        ),
        // toolbarHeight: 70,
        backgroundColor: kTealColor,
        elevation: 2,
        title: Align(
          alignment: Alignment.topLeft,
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 24,
                color: Colors.black87,
                fontWeight: FontWeight.w300,
              ),
              children: [
                TextSpan(text: 'Diary'),
                TextSpan(
                  text: 'Book',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),

        actions: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              final userListSteam = snapshot.data!.docs.map((docs) {
                return MUser.fromDocument(docs);
              }).where((muser) {
                return (muser.uid == FirebaseAuth.instance.currentUser!.uid);
              }).toList();

              MUser curUser = userListSteam[0];

              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                        items: <String>['Latest', 'Earliest'].map(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        hint: (_dropDownText == null)
                            ? const Text(
                                'Select',
                                style: TextStyle(color: Colors.white),
                              )
                            : Text(_dropDownText!),
                        onChanged: (value) {
                          if (value == 'Latest') {
                            setState(() {
                              _dropDownText = value;
                            });
                          } else if (value == 'Earliest') {
                            setState(() {
                              _dropDownText = value;
                            });
                          }
                        }),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 16,
                                    backgroundImage:
                                        NetworkImage(curUser.avatarUrl!),
                                  ),
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CreateProfileAlertDialog(
                                        curUser: curUser);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        return Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      });
                    },
                    icon: const Icon(
                      Icons.logout_outlined,
                      size: 24,
                      color: kTeal100Color,
                    ),
                    label: const Text(''),
                  )
                ],
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          final userListSteam = snapshot.data!.docs.map((docs) {
            return MUser.fromDocument(docs);
          }).where((muser) {
            return (muser.uid == FirebaseAuth.instance.currentUser!.uid);
          }).toList();

          MUser curUser = userListSteam[0];

          return CreateProfile(curUser: curUser);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 2,
        tooltip: 'Add',
        child: const Icon(Icons.add),
        backgroundColor: kButtonColor,
      ),
    );
  }
}
