import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_attendence_app/models/student.dart';
import 'package:online_attendence_app/services/Firebase/creation.dart';
import 'package:online_attendence_app/services/Firebase/queries.dart';
import 'package:online_attendence_app/services/Firebase/updation.dart';
import 'package:online_attendence_app/utils/error_alert.dart';
import 'package:online_attendence_app/widgets/add_person_button.dart';
import 'package:online_attendence_app/widgets/custom_list_tile.dart';
import 'package:online_attendence_app/widgets/labeled_text_field.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key, this.members, this.classId})
      : super(key: key);
  final members;
  final classId;
  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final registrationNo = TextEditingController();
  final creation = Creation();
  final updation = Updation();
  int? members;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    members = widget.members;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white.withOpacity(0.4),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Add Student',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                LabeledFormField(
                    controller: name,
                    onValidate: (value) {
                      if (value.isEmpty || value == null) {
                        return "Value required!";
                      }
                    },
                    label: 'Student Name ',
                    hintText: 'Enter student name'),
                SizedBox(
                  height: 25,
                ),
                LabeledFormField(
                    controller: registrationNo,
                    onValidate: (value) {
                      if (value.isEmpty || value == null) {
                        return "Value required!";
                      }
                    },
                    label: 'Student Registration No ',
                    hintText: 'Enter registration no'),
                SizedBox(
                  height: 25,
                ),
                AddPersonButton(action: () {
                  if (formKey.currentState!.validate()) {
                    addStudent(context, name.text, registrationNo.text);
                    setState(() {
                      name.text = '';
                      registrationNo.text = '';
                    });
                  }
                }),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: getStudents(classId: widget.classId),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return Container();

                        List<Widget> widgetsList = [];

                        for (var document in snapshot.data!.docs) {
                          Student studentModel = Student.fromDocument(document);

                          var widget = CustomListTile(
                              title: studentModel.name!,
                              id: studentModel.registrationNo!,
                              trailingWidget: Container());

                          widgetsList.add(widget);
                        }
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widgetsList,
                            ),
                          ),
                        );
                      }),
                )
              ],
            )),
        // ),
      ),
    );
  }

  addStudent(context, name, registrationNo) async {
    try {
      await creation.addStudent(
          classId: widget.classId,
          studentModel: Student(name: name, registrationNo: registrationNo));
      await updation.updateClassMembersCount(
          classId: widget.classId, members: members! + 1);
      members = members! + 1;
    } catch (e) {
      showInfoAlert(context: context, title: 'An error occurred.');
    }
  }
}
