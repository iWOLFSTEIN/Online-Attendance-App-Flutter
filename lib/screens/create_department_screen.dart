import 'package:flutter/material.dart';
import 'package:online_attendence_app/screens/nav_bar_controller_screen.dart';
import 'package:online_attendence_app/widgets/custom_text_button.dart';
import 'package:online_attendence_app/widgets/labeled_text_field.dart';

class CreateDepartmentScreen extends StatelessWidget {
  CreateDepartmentScreen({Key? key}) : super(key: key);

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
          'Create Department',
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
                      label: 'Department ', hintText: 'Enter name'),
                  SizedBox(
                    height: 25,
                  ),
                  LabeledFormField(
                      label: 'Organization ', hintText: 'Enter name'),
                  SizedBox(
                    height: 25,
                  ),
                  LabeledFormField(label: 'Field ', hintText: 'Enter name'),
                  SizedBox(
                    height: 25,
                  ),
                  LabeledFormField(label: 'Location ', hintText: 'Enter name'),
                  SizedBox(
                    height: 25,
                  ),
                  LabeledFormField(
                      label: 'Profession ', hintText: 'Enter name'),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomTextButton(
                      buttonHeight: 50,
                      action: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavBarControllerScreen(
                                      initPageIndex: 2,
                                    )),
                            (route) => false);
                      },
                      title: 'Create Department',
                      fontSize: 17,
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
