import 'package:flutter/material.dart';
import 'package:online_attendence_app/constants/user_constants.dart';
import 'package:online_attendence_app/models/department.dart';
import 'package:online_attendence_app/screens/nav_bar_controller_screen.dart';
import 'package:online_attendence_app/services/firebase/creation.dart';
import 'package:online_attendence_app/utils/error_alert.dart';
import 'package:online_attendence_app/widgets/custom_text_button.dart';
import 'package:online_attendence_app/widgets/labeled_text_field.dart';

class CreateDepartmentScreen extends StatefulWidget {
  CreateDepartmentScreen({Key? key}) : super(key: key);

  @override
  State<CreateDepartmentScreen> createState() => _CreateDepartmentScreenState();
}

class _CreateDepartmentScreenState extends State<CreateDepartmentScreen> {
  final formKey = GlobalKey<FormState>();

  final department = TextEditingController();

  final organization = TextEditingController();

  final field = TextEditingController();

  final location = TextEditingController();

  final profession = TextEditingController();

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
                      controller: department,
                      onValidate: (value) {
                        if (value.isEmpty || value == null) {
                          return "Value required!";
                        }
                      },
                      label: 'Department ',
                      hintText: 'Enter name'),
                  SizedBox(
                    height: 25,
                  ),
                  LabeledFormField(
                      controller: organization,
                      onValidate: (value) {
                        if (value.isEmpty || value == null) {
                          return "Value required!";
                        }
                      },
                      label: 'Organization ',
                      hintText: 'Enter name'),
                  SizedBox(
                    height: 25,
                  ),
                  LabeledFormField(
                      controller: field,
                      onValidate: (value) {
                        if (value.isEmpty || value == null) {
                          return "Value required!";
                        }
                      },
                      label: 'Field ',
                      hintText: 'Enter name'),
                  SizedBox(
                    height: 25,
                  ),
                  LabeledFormField(
                      controller: location,
                      onValidate: (value) {
                        if (value.isEmpty || value == null) {
                          return "Value required!";
                        }
                      },
                      label: 'Location ',
                      hintText: 'Enter name'),
                  SizedBox(
                    height: 25,
                  ),
                  LabeledFormField(
                      controller: profession,
                      onValidate: (value) {
                        if (value.isEmpty || value == null) {
                          return "Value required!";
                        }
                      },
                      label: 'Profession ',
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
                          createDepartment(
                              context,
                              department.text,
                              organization.text,
                              field.text,
                              location.text,
                              profession.text);
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

  createDepartment(
      context, department, organization, field, location, profession) async {
    try {
      final dateTime = DateTime.now();
      setState(() {
        isCreating = true;
      });
      creation.createDepartment(
          departmentModel: Department(
              department: department,
              organization: organization,
              field: field,
              location: location,
              profession: profession,
              members: 0,
              creationTime: dateTime));
      setState(() {
        isCreating = false;
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => NavBarControllerScreen(
                    initPageIndex: 2,
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
