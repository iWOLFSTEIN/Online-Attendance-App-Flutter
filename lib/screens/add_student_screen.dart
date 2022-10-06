import 'package:flutter/material.dart';
import 'package:online_attendence_app/widgets/add_person_button.dart';
import 'package:online_attendence_app/widgets/custom_list_tile.dart';
import 'package:online_attendence_app/widgets/labeled_text_field.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  @override
  Widget build(BuildContext context) {
    var title = 'Ahmad Khan';
    var id = 'Spring/Bcs/0011';
    var trailingWidget = Container();
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
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            LabeledFormField(
                label: 'Student Name ', hintText: 'Enter student name'),
            SizedBox(
              height: 25,
            ),
            LabeledFormField(
                label: 'Student Registration No ',
                hintText: 'Enter registration no'),
            SizedBox(
              height: 25,
            ),
            AddPersonButton(action: () {}),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < 10; i++)
                        CustomListTile(
                            title: title,
                            id: id,
                            trailingWidget: trailingWidget),
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
