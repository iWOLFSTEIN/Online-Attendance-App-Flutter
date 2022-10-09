import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_attendence_app/constants/user_constants.dart';
import 'package:online_attendence_app/models/class.dart';
import 'package:online_attendence_app/screens/nav_bar_controller_screen.dart';
import 'package:online_attendence_app/services/firebase/creation.dart';
import 'package:online_attendence_app/utils/error_alert.dart';
import 'package:online_attendence_app/widgets/custom_text_button.dart';
import 'package:online_attendence_app/widgets/labeled_text_field.dart';

class CreateClassScreen extends StatefulWidget {
  CreateClassScreen({Key? key}) : super(key: key);

  @override
  State<CreateClassScreen> createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  final formKey = GlobalKey<FormState>();
  final schoolCollege = TextEditingController();
  final semesterSection = TextEditingController();
  final program = TextEditingController();
  final subject = TextEditingController();
  final session = TextEditingController();
  final creation = Creation();

  bool isCreating = false;

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
      body: ModalProgressHUD(
        inAsyncCall: isCreating,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    LabeledFormField(
                        controller: schoolCollege,
                        onValidate: (value) {
                          if (value.isEmpty || value == null) {
                            return "Value required!";
                          }
                        },
                        label: 'School/College ',
                        hintText: 'Enter name'),
                    SizedBox(
                      height: 25,
                    ),
                    LabeledFormField(
                        controller: semesterSection,
                        onValidate: (value) {
                          if (value.isEmpty || value == null) {
                            return "Value required!";
                          }
                        },
                        label: 'Semester/Section ',
                        hintText: 'Enter name'),
                    SizedBox(
                      height: 25,
                    ),
                    LabeledFormField(
                        controller: program,
                        onValidate: (value) {
                          if (value.isEmpty || value == null) {
                            return "Value required!";
                          }
                        },
                        label: 'Program ',
                        hintText: 'Enter name'),
                    SizedBox(
                      height: 25,
                    ),
                    LabeledFormField(
                        controller: subject,
                        onValidate: (value) {
                          if (value.isEmpty || value == null) {
                            return "Value required!";
                          }
                        },
                        label: 'Subject ',
                        hintText: 'Enter name'),
                    SizedBox(
                      height: 25,
                    ),
                    LabeledFormField(
                        controller: session,
                        onValidate: (value) {
                          if (value.isEmpty || value == null) {
                            return "Value required!";
                          }
                        },
                        label: 'Session ',
                        hintText: 'Enter name'),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomTextButton(
                        buttonHeight: 50,
                        action: () {
                          if (formKey.currentState!.validate())
                            createClass(
                                context,
                                schoolCollege.text,
                                semesterSection.text,
                                program.text,
                                subject.text,
                                session.text);
                        },
                        title: 'Create Class',
                        fontSize: 17,
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  createClass(context, schoolCollege, semesterSection, program, subject,
      session) async {
    try {
      final dateTime = DateTime.now();
      setState(() {
        isCreating = true;
      });
      await creation.createClass(
          classModel: Class(
              schoolCollege: schoolCollege,
              semesterSection: semesterSection,
              program: program,
              subject: subject,
              session: session,
              members: 0,
              creationTime: dateTime));
      setState(() {
        isCreating = false;
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => NavBarControllerScreen(
                    initPageIndex: 1,
                  )),
          (route) => false);
    } catch (e) {
      setState(() {
        isCreating = false;
      });
      showInfoAlert(context: context, title: 'An error occurred.');
    }
  }
}
