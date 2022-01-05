import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_webapp/constants/constants.dart';
import 'package:diary_webapp/model/diary.dart';
import 'package:diary_webapp/utils/utils.dart';
import 'package:diary_webapp/widgets/delete_entry_dialogue.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

// import 'package:flutter/widgets.dart';

class DiaryListView extends StatelessWidget {
  const DiaryListView({
    required this.selectedDate,
    required this.diary,
    Key? key,
  }) : super(key: key);
  final DateTime selectedDate;
  final Diary diary;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleTextController =
        TextEditingController(text: diary.title);
    final TextEditingController _descriptionTextController =
        TextEditingController(text: diary.entry);

    CollectionReference diariesCollectionReference =
        FirebaseFirestore.instance.collection('diaries');
    return StreamBuilder<QuerySnapshot>(
        stream: diariesCollectionReference.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          var filteredList = snapshot.data!.docs.map((diary) {
            return Diary.fromDocument(diary);
          }).where((item) {
            return (item.userId == FirebaseAuth.instance.currentUser!.uid);
          }).toList();
          return Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        Diary diary = filteredList[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Card(
                            margin: const EdgeInsets.fromLTRB(60, 45, 60, 0),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 2,
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  title: Padding(
                                    padding: const EdgeInsets.all(30),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                style: const TextStyle(
                                                    color: kLightGrey,
                                                    fontWeight:
                                                        FontWeight.w300),
                                                children: [
                                                  TextSpan(
                                                      text: formatDate(
                                                        diary.entryTime!
                                                            .toDate(),
                                                      ),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                  TextSpan(
                                                    text: formatTime(
                                                      diary.entryTime!.toDate(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return DeleteEntryDialogue(
                                                            diariesCollectionReference:
                                                                diariesCollectionReference,
                                                            diary: diary);
                                                      },
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete_forever,
                                                  ),
                                                  color: kLightGrey,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    primary: kTealColor,
                                                  ),
                                                  onPressed: () {},
                                                  child: const Icon(
                                                    Icons.more_vert_rounded,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            color: kLightGrey),
                                        child: SizedBox(
                                          // height: 400,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Image.network(
                                            (diary.photoUrls == null)
                                                ? 'https://picsum.photos/400/200.webp'
                                                : diary.photoUrls.toString(),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(30),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('${diary.title}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                      color: kDarkGrey,
                                                    )),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              '${diary.entry}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    color: kLightGrey,
                                                    height: 1.5,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          elevation: 2,
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(16.0),
                                            ),
                                          ),
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 30),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    style: const TextStyle(
                                                        color: kLightGrey,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                    children: [
                                                      TextSpan(
                                                          text: formatDate(
                                                            diary.entryTime!
                                                                .toDate(),
                                                          ),
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          )),
                                                      TextSpan(
                                                        text: formatTime(
                                                          diary.entryTime!
                                                              .toDate(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return DeleteEntryDialogue(
                                                                diariesCollectionReference:
                                                                    diariesCollectionReference,
                                                                diary: diary);
                                                          },
                                                        );
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete_forever,
                                                      ),
                                                      color: kLightGrey,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    IconButton(
                                                      color: kTealColor,
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              elevation: 2,
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .all(0),
                                                              shape:
                                                                  const RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          16.0),
                                                                ),
                                                              ),
                                                              title: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            20),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    RichText(
                                                                      text:
                                                                          TextSpan(
                                                                        style: const TextStyle(
                                                                            color:
                                                                                kLightGrey,
                                                                            fontWeight:
                                                                                FontWeight.w300),
                                                                        children: [
                                                                          TextSpan(
                                                                              text: formatDate(
                                                                                diary.entryTime!.toDate(),
                                                                              ),
                                                                              style: const TextStyle(
                                                                                fontWeight: FontWeight.w500,
                                                                              )),
                                                                          TextSpan(
                                                                            text:
                                                                                formatTime(
                                                                              diary.entryTime!.toDate(),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return DeleteEntryDialogue(diariesCollectionReference: diariesCollectionReference, diary: diary);
                                                                              },
                                                                            );
                                                                          },
                                                                          icon:
                                                                              const Icon(
                                                                            Icons.delete_forever,
                                                                          ),
                                                                          color:
                                                                              kLightGrey,
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        IconButton(
                                                                          onPressed:
                                                                              () {},
                                                                          icon:
                                                                              const Icon(
                                                                            Icons.add_photo_alternate_outlined,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              content:
                                                                  SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                child: SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.60,
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        decoration:
                                                                            const BoxDecoration(color: kLightGrey),
                                                                        child:
                                                                            SizedBox(
                                                                          // height: 400,
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          child:
                                                                              Image.network(
                                                                            (diary.photoUrls == null)
                                                                                ? 'https://picsum.photos/400/200.webp'
                                                                                : diary.photoUrls.toString(),
                                                                            fit:
                                                                                BoxFit.fitHeight,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Form(
                                                                          child:
                                                                              Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(30.0),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            TextFormField(
                                                                              decoration: const InputDecoration(hintText: 'Title...'),
                                                                              controller: _titleTextController,
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 30,
                                                                            ),
                                                                            TextFormField(
                                                                              maxLines: null,
                                                                              validator: (value) {},
                                                                              keyboardType: TextInputType.multiline,
                                                                              decoration: const InputDecoration(hintText: 'Wright your thoughts here...'),
                                                                              controller: _descriptionTextController,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ))
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              actions: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          0.0,
                                                                          20.0,
                                                                          10.0,
                                                                          20.0),
                                                                  child:
                                                                      TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Future
                                                                          .delayed(
                                                                        const Duration(
                                                                            microseconds:
                                                                                200),
                                                                      ).then(
                                                                        (value) {
                                                                          return Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      );
                                                                    },
                                                                    child: const Text(
                                                                        'Cancel'),
                                                                    style: TextButton
                                                                        .styleFrom(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        vertical:
                                                                            20,
                                                                        horizontal:
                                                                            25,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          10.0,
                                                                          20.0,
                                                                          20.0,
                                                                          20.0),
                                                                  child:
                                                                      TextButton(
                                                                    onPressed:
                                                                        () {},
                                                                    child: const Text(
                                                                        'Update'),
                                                                    style: TextButton
                                                                        .styleFrom(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        vertical:
                                                                            20,
                                                                        horizontal:
                                                                            25,
                                                                      ),
                                                                      backgroundColor:
                                                                          kButtonColor,
                                                                      primary:
                                                                          kWhiteColor,
                                                                      shape:
                                                                          const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                          Radius.circular(
                                                                              6),
                                                                        ),
                                                                        side:
                                                                            BorderSide(
                                                                          color:
                                                                              kButtonColor,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                            // return const UpdateEntryDialog();
                                                          },
                                                        );
                                                      },
                                                      icon: const Icon(
                                                        Icons.edit_rounded,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          content: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.80,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: kLightGrey),
                                                    child: SizedBox(
                                                      // height: 400,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Image.network(
                                                        (diary.photoUrls ==
                                                                null)
                                                            ? 'https://picsum.photos/400/200.webp'
                                                            : diary.photoUrls
                                                                .toString(),
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            30),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text('${diary.title}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6!
                                                                .copyWith(
                                                                  color:
                                                                      kDarkGrey,
                                                                )),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          '${diary.entry}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    color:
                                                                        kLightGrey,
                                                                    height: 1.5,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
