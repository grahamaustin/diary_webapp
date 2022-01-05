import 'package:diary_webapp/constants/constants.dart';
import 'package:diary_webapp/model/diary.dart';

import 'package:diary_webapp/model/user.dart';
import 'package:diary_webapp/widgets/diary_list_view.dart';
import 'package:diary_webapp/widgets/wright_diary_alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'create_profile_alert_dialogue.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({
    Key? key,
    required this.curUser,
  }) : super(key: key);

  final MUser curUser;

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final _titleTextController = TextEditingController();
    final _descriptionTextController = TextEditingController();

    
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border(
                right: BorderSide(
                  width: 0.4,
                  color: kLightDivide,
                ),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    // height: 300,
                    decoration: const BoxDecoration(color: kTealColor),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: Column(
                        children: [
                          InkWell(
                            child: CircleAvatar(
                              radius: 98,
                              backgroundColor: kTeal100Color,
                              child: CircleAvatar(
                                radius: 92,
                                backgroundColor: kWhiteColor,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(widget.curUser.avatarUrl!),
                                  radius: 80,
                                  backgroundColor: kTealColor,
                                ),
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CreateProfileAlertDialog(
                                      curUser: widget.curUser);
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.curUser.displayName!.capitalize(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(38.0),
                    child: SfDateRangePicker(
                      onSelectionChanged: (dateRangePickerSelection) {
                        setState(() {
                          selectedDate = dateRangePickerSelection.value;
                        });

                        // print(dateRangePickerSelection.value.toString());
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                        primary: kTealColor,
                        onPrimary: kWhiteColor,
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        minimumSize: const Size(double.infinity,
                            30), // double.infinity is the width and 30 is the height
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return WrightDiaryAlertDialog(
                              selectedDate: selectedDate,
                              titleTextController: _titleTextController,
                              descriptionTextController:
                                  _descriptionTextController,
                            );
                          },
                        );
                      },
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.add,
                          size: 34,
                          color: Colors.white,
                        ),
                      ),
                      label: Text(
                        'Add New Entry'.toUpperCase(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        DiaryListView(
          diary:_descriptionTextController.text,
          
          selectedDate: selectedDate,
        ),
      ],
    );
  }
}
