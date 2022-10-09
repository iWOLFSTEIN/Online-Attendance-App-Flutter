import 'package:flutter/material.dart';
import 'package:online_attendence_app/models/teacher.dart';
import 'package:online_attendence_app/services/firebase/queries.dart';
import 'package:online_attendence_app/widgets/add_person_button.dart';
import 'package:online_attendence_app/widgets/custom_list_tile.dart';
import 'package:online_attendence_app/widgets/labeled_text_field.dart';

import '../services/firebase/creation.dart';
import '../services/firebase/updation.dart';
import '../utils/error_alert.dart';

class AddTeacherScreen extends StatefulWidget {
  const AddTeacherScreen({Key? key, this.departmentId, this.members})
      : super(key: key);
  final departmentId;
  final members;
  @override
  State<AddTeacherScreen> createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final id = TextEditingController();
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
          'Add Teacher',
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
                    label: 'Teacher Name ',
                    hintText: 'Enter teacher name'),
                SizedBox(
                  height: 25,
                ),
                LabeledFormField(
                    controller: id,
                    onValidate: (value) {
                      if (value.isEmpty || value == null) {
                        return "Value required!";
                      }
                    },
                    label: 'Teacher id ',
                    hintText: 'Enter teacher id'),
                SizedBox(
                  height: 25,
                ),
                AddPersonButton(action: () {
                  if (formKey.currentState!.validate()) {
                    addTeacher(context, name.text, id.text);
                    setState(() {
                      name.text = '';
                      id.text = '';
                    });
                  }
                }),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: StreamBuilder(
                        stream: getTeachers(departmentId: widget.departmentId),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return Container();

                          List<Widget> widgetsList = [];

                          for (var document in snapshot.data!.docs) {
                            Teacher teacherModel =
                                Teacher.fromDocument(document);

                            var widget = CustomListTile(
                                title: teacherModel.name!,
                                id: teacherModel.id!,
                                trailingWidget: Container());

                            widgetsList.add(widget);
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widgetsList,
                            ),
                          );
                        }),
                  ),
                )
              ],
            )),
      ),
    );
  }

  addTeacher(context, name, id) async {
    try {
      await creation.addTeacher(
          teacherModel: Teacher(name: name, id: id),
          departmentId: widget.departmentId);
      await updation.updateDepartmentMembersCount(
          departmentId: widget.departmentId, members: members! + 1);
      members = members! + 1;
    } catch (e) {
      showInfoAlert(context: context, title: 'An error occurred.');
    }
  }
}
