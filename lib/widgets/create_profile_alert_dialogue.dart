import 'package:diary_webapp/constants/constants.dart';
import 'package:diary_webapp/model/user.dart';
import 'package:diary_webapp/services/service.dart';
import 'package:diary_webapp/widgets/input_decorator.dart';
import 'package:flutter/material.dart';

class CreateProfileAlertDialog extends StatelessWidget {
  const CreateProfileAlertDialog({
    Key? key,
    required this.curUser,
  }) : super(key: key);

  final MUser curUser;

  @override
  Widget build(BuildContext context) {
    final _avatarUrlTextController =
        TextEditingController(text: curUser.avatarUrl);
    final _displayNameTextController =
        TextEditingController(text: curUser.displayName);
    final _professionTextController =
        TextEditingController(text: curUser.profession);

    return AlertDialog(
      elevation: 3,
      contentPadding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: kTealColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.25,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 16, 30),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: kTeal100Color,
                        child: CircleAvatar(
                          radius: 44,
                          backgroundColor: kWhiteColor,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(curUser.avatarUrl!),
                            backgroundColor: kTealColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        curUser.displayName!.capitalize(),
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: kWhiteColor,
                              height: 1.5,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.2,
                            ),
                      ),
                      Text(
                        curUser.emailAddress!,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: kTeal100Color,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.2,
                            ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit Profile Info',
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: kDarkGrey,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                          letterSpacing: -0.2,
                        ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: inputDecorationOnWhite(
                              'Avatar URL', 'Entry Avatar URL'),
                          controller: _avatarUrlTextController,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: inputDecorationOnWhite(
                              'Display Name', 'Charge Display Name'),
                          controller: _displayNameTextController,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: inputDecorationOnWhite(
                              'Profession', 'Entry Profession'),
                          controller: _professionTextController,
                        ),
                        const SizedBox(
                          height: 36,
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
                                DiaryService().update(
                                    _avatarUrlTextController.text,
                                    _displayNameTextController.text,
                                    curUser.emailAddress!.toString(),
                                    _professionTextController.text,
                                    curUser,
                                    context);
                                Future.delayed(
                                  const Duration(microseconds: 200),
                                ).then(
                                  (value) {
                                    return Navigator.of(context).pop();
                                  },
                                );
                              },
                              child: const Text('Update Profile'),
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
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
