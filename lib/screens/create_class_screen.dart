import 'package:flutter/material.dart';
import 'package:online_attendence_app/screens/nav_bar_controller_screen.dart';
import 'package:online_attendence_app/widgets/custom_text_button.dart';
import 'package:online_attendence_app/widgets/labeled_text_field.dart';

class CreateClassScreen extends StatelessWidget {
  CreateClassScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white.withOpacity(0.4),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Create Class',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  LabeledFormField(
                      label: 'School/College ', hintText: 'Enter name'),
                  SizedBox(
                    height: 25,
                  ),
                  LabeledFormField(
                      label: 'Semester/Section ', hintText: 'Enter name'),
                  SizedBox(
                    height: 25,
                  ),
                  LabeledFormField(label: 'Program ', hintText: 'Enter name'),
                  SizedBox(
                    height: 25,
                  ),
                  LabeledFormField(label: 'Subject ', hintText: 'Enter name'),
                  SizedBox(
                    height: 25,
                  ),
                  LabeledFormField(label: 'Session ', hintText: 'Enter name'),
                  SizedBox(
                    height: 25,
                  ),
                  CustomTextButton(
                    buttonHeight: 60,
                    action: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavBarControllerScreen(
                                    initPageIndex: 1,
                                  )),
                          (route) => false);
                    },
                    title: 'Create Class',
                    fontSize: 18,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
