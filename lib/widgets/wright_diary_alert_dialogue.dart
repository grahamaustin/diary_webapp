import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_webapp/constants/constants.dart';
import 'package:diary_webapp/model/diary.dart';
import 'package:diary_webapp/utils/utils.dart';
import 'package:diary_webapp/widgets/input_decorator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
// import 'package:mime_type/mime_type.dart';
// import 'package:path/path.dart' as path;
// import 'dart:html' as html;

class WrightDiaryAlertDialog extends StatefulWidget {
  const WrightDiaryAlertDialog({
    Key? key,
    this.selectedDate,
    required TextEditingController titleTextController,
    required TextEditingController descriptionTextController,
  })  : _titleTextController = titleTextController,
        _descriptionTextController = descriptionTextController,
        super(key: key);

  final TextEditingController _titleTextController;
  final TextEditingController _descriptionTextController;
  final DateTime? selectedDate;

  @override
  State<WrightDiaryAlertDialog> createState() => _WrightDiaryAlertDialogState();
}

class _WrightDiaryAlertDialogState extends State<WrightDiaryAlertDialog> {
  // html.File? _cloudFile;
  var _fileBytes;
  String? currId;
  Image? _imageWidget;

  var _buttonText = 'Update Entry';
  final CollectionReference diaryCollectionReference =
      FirebaseFirestore.instance.collection('diaries');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 2,
      contentPadding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: Column(
            children: [
              Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                    color: kLightGrey,
                                    fontWeight: FontWeight.w300),
                                children: [
                                  TextSpan(
                                      text: formatDate(widget.selectedDate!),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                  TextSpan(
                                    text: formatTime(widget.selectedDate!),
                                  )
                                ]),
                          ),
                          // Text(
                          //   formatDate(widget.selectedDate!),
                          // ),
                          IconButton(
                            splashRadius: 26,
                            onPressed: () async {
                              await getMultipleImageInfos();
                            },
                            icon: const Icon(
                              Icons.add_photo_alternate_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 350,
                      decoration: const BoxDecoration(
                        color: kTealColor,
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(16),
                        //   topRight: Radius.circular(16),
                        // ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: _imageWidget,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            // decoration: inputDecorationOnWhite(Title),
                            controller: widget._titleTextController,
                            decoration:
                                inputDecorationOnWhite('Title', 'Entry title'),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            // decoration: inputDecorationOnWhite(Title),
                            controller: widget._descriptionTextController,
                            decoration: inputDecorationOnWhite(
                                'Description', 'Entry text'),
                            maxLines: null,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Future.delayed(
                                    const Duration(microseconds: 200),
                                  ).then(
                                    (value) {
                                      return Navigator.of(context).pop();
                                    },
                                  );
                                },
                                child: const Text('Cancel'),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 25,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TextButton(
                                onPressed: () {
                                  firebase_storage.FirebaseStorage fs =
                                      firebase_storage.FirebaseStorage.instance;
                                  final dateTime = DateTime.now();
                                  final path = '$dateTime';
                                  final _fieldsNotEmpty = widget
                                          ._titleTextController
                                          .toString()
                                          .isNotEmpty &&
                                      widget._descriptionTextController.text
                                          .toString()
                                          .isNotEmpty;

                                  if (_fieldsNotEmpty) {
                                    diaryCollectionReference
                                        .add(Diary(
                                                title: widget
                                                    ._titleTextController.text,
                                                entry: widget
                                                    ._descriptionTextController
                                                    .text,
                                                author: FirebaseAuth.instance
                                                    .currentUser!.email!
                                                    .split('@')[0],
                                                userId: FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                entryTime: Timestamp.fromDate(
                                                    widget.selectedDate!))
                                            .toMap())
                                        .then((value) {
                                      setState(() {
                                        currId = value.id;
                                      });
                                      return null;
                                    });
                                  }

                                  if (_fileBytes != null) {
                                    firebase_storage.SettableMetadata?
                                        metadata =
                                        firebase_storage.SettableMetadata(
                                            contentType: 'image/jpeg',
                                            customMetadata: {
                                          'picked-file-path': path
                                        });

                                    Future.delayed(
                                            const Duration(milliseconds: 1100))
                                        .then((value) {
                                      fs
                                          .ref()
                                          .child(
                                              'images/$path${FirebaseAuth.instance.currentUser!.uid}')
                                          .putData(_fileBytes, metadata)
                                          .then((value) {
                                        return value.ref
                                            .getDownloadURL()
                                            .then((value) {
                                          diaryCollectionReference
                                              .doc(currId)
                                              .update({
                                            'photo_list': value.toString()
                                          });
                                        });
                                      });
                                      return null;
                                    });
                                  }

                                  setState(() {
                                    _buttonText = 'Saving...';
                                  });
                                  Future.delayed(
                                    const Duration(milliseconds: 2500),
                                  ).then(
                                      (value) => Navigator.of(context).pop());
                                },
                                child: Text(_buttonText),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 25,
                                  ),
                                  backgroundColor: kButtonColor,
                                  primary: kWhiteColor,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                    side: BorderSide(
                                      color: kButtonColor,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getMultipleImageInfos() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    //String? mimeType = mime(Path.basename(mediaData.fileName!));
    // html.File mediaFile =
    //     new html.File(mediaData.data!, mediaData.fileName!, {'type': mimeType});

    setState(() {
      // _cloudFile = mediaFile;
      _fileBytes = mediaData.data;
      _imageWidget = Image.memory(mediaData.data!);
    });
  }
}
