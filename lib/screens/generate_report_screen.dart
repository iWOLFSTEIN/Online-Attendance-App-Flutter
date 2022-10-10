import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_attendence_app/models/attendance.dart';
import 'package:online_attendence_app/models/class.dart';
import 'package:online_attendence_app/models/department.dart';
import 'package:online_attendence_app/provider/data_provider.dart';
import 'package:online_attendence_app/services/firebase/queries.dart';
import 'package:online_attendence_app/utils/app_directory.dart';
import 'package:online_attendence_app/utils/error_alert.dart';
import 'package:online_attendence_app/utils/screen_dimensions.dart';
import 'package:online_attendence_app/utils/stream_builder_states.dart';
import 'package:online_attendence_app/widgets/custom_text_button.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';

class GenerateReportScreen extends StatefulWidget {
  const GenerateReportScreen({Key? key}) : super(key: key);

  @override
  State<GenerateReportScreen> createState() => _GenerateReportScreenState();
}

class _GenerateReportScreenState extends State<GenerateReportScreen> {
  // bool isClass = false;
  // String? dropDownValueClass;
  // String? dropDownValueDepartment;
  // List<String> itemsClass = [
  //   'Class 1',
  //   'Class 2',
  //   'Class 3',
  //   'Class 4',
  //   'Class 5'
  // ];
  // List<String> itemsDepartment = [
  //   'Department 1',
  //   'Department 2',
  //   'Department 3',
  //   'Department 4',
  //   'Department 5'
  // ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dropDownValueClass = itemsClass[0];
    // dropDownValueDepartment = itemsDepartment[0];
  }

  var dropDownValue;
  var documentId;
  var startDate = DateTime.now();
  var endDate = DateTime.now();
  bool isGeneratingReport = false;
  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFFEAF6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white.withOpacity(0.4),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Generate Report',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: (isGeneratingReport)
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  tabSelector(dataProvider),
                  SizedBox(
                    height: 25,
                  ),
                  customDropDownButton(dataProvider),
                  SizedBox(
                    height: 25,
                  ),
                  customDatePicker(
                    context,
                    'Start',
                    startDate,
                    () async {
                      var picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: const Color(0xFF8CE7F1),
                                  accentColor: const Color(0xFF8CE7F1),
                                  colorScheme: ColorScheme.light(
                                      primary: const Color(0xFF8CE7F1)),
                                  buttonTheme: ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary),
                                ),
                                child: child!);
                          });

                      if (picked != null) {
                        setState(() {
                          startDate = picked;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  customDatePicker(
                    context,
                    'End',
                    endDate,
                    () async {
                      var picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: const Color(0xFF8CE7F1),
                                  accentColor: const Color(0xFF8CE7F1),
                                  colorScheme: ColorScheme.light(
                                      primary: const Color(0xFF8CE7F1)),
                                  buttonTheme: ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary),
                                ),
                                child: child!);
                          });

                      if (picked != null) {
                        setState(() {
                          endDate = picked;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  CustomTextButton(
                      buttonHeight: 50,
                      action: () async {
                        if (dropDownValue != null && documentId != null) {
                          setState(() {
                            isGeneratingReport = true;
                          });
                          try {
                            Future attendancesFutureData =
                                (dataProvider.isClass)
                                    ? getStudentsAttendancesFutureData(
                                        classId: documentId)
                                    : getTeachersAttendancesFutureData(
                                        departmentId: documentId);

                            attendancesFutureData.then((event) async {
                              if (!listEquals(event.docs, [])) {
                                final pdf = pw.Document();
                                int attendanceCount = 0;
                                for (var document in event.docs) {
                                  Attendance attendanceModel =
                                      Attendance.fromDocument(document);

                                  if (attendanceModel.creationTime!
                                          .isAfter(startDate) &&
                                      attendanceModel.creationTime!
                                          .isBefore(endDate)) {
                                    List<pw.Widget> widgetsList = [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.only(bottom: 25),
                                        child: pw.Text(
                                            attendanceModel.creationTime!
                                                .toString(),
                                            style: pw.TextStyle(
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                      ),
                                    ];
                                    attendanceModel.attendance!
                                        .forEach((key, value) {
                                      value.forEach((subKey, subValue) {
                                        var widget = pw.Padding(
                                            padding:
                                                pw.EdgeInsets.only(bottom: 5),
                                            child: pw.Row(
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              children: [
                                                pw.Expanded(
                                                    child: pw.Center(
                                                        child:
                                                            pw.Text(subKey))),
                                                pw.Expanded(
                                                    child: pw.Center(
                                                        child: pw.Text(key))),
                                                pw.Expanded(
                                                    child: pw.Center(
                                                        child: pw.Text(
                                                            (subValue)
                                                                ? 'Present'
                                                                : 'Absent'))),
                                              ],
                                            ));
                                        widgetsList.add(widget);
                                      });
                                    });

                                    pdf.addPage(pw.Page(
                                        pageFormat: PdfPageFormat.a4,
                                        build: (pw.Context context) {
                                          return pw.Column(
                                              children: widgetsList);
                                        }));
                                    attendanceCount = attendanceCount + 1;
                                  }
                                }
                                setState(() {
                                  isGeneratingReport = false;
                                });
                                if (attendanceCount != 0) {
                                  DateTime dateTime = DateTime.now();
                                  final path = await getAppDirectory() +
                                      '/file${dateTime.microsecondsSinceEpoch}';
                                  final file = File(path);
                                  await file
                                      .writeAsBytes(await pdf.save())
                                      .then((value) {
                                    OpenFile.open(path);
                                  });
                                } else {
                                  showInfoAlert(
                                      context: context,
                                      title:
                                          'Please select a valid start date!');
                                }
                              } else {
                                setState(() {
                                  isGeneratingReport = false;
                                });
                                showInfoAlert(
                                    context: context,
                                    title: 'No Attendance Records Found!');
                              }
                            });
                          } catch (e) {
                            setState(() {
                              isGeneratingReport = false;
                            });
                            showInfoAlert(
                                context: context, title: 'An error occurred!');
                          }
                        } else {
                          showInfoAlert(
                              context: context,
                              title: (dataProvider.isClass)
                                  ? 'No Classes Created!'
                                  : 'No Departments Created!');
                        }
                      },
                      title: 'Generate',
                      fontSize: 18)
                ],
              ),
            ),
    );
  }

  Padding customDatePicker(BuildContext context, name, date, voidCallBack) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: voidCallBack,
        child: Container(
          height: height(context) * 7 / 100,
          child: Row(
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w400),
              ),
              Expanded(child: SizedBox()),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    date.toString().split(' ')[0],
                    style: TextStyle(
                        color: Color(0xFF06283D),
                        fontSize: 17.5,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.date_range,
                      color: Color(0xFF06283D),
                      size: 27.5,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding customDropDownButton(dataProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (dataProvider.isClass) ? 'Class' : 'Department',
            style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder(
              stream: (dataProvider.isClass) ? getClasses : getDepartments,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return placeholderContainer('loading...');
                }
                if (listEquals(snapshot.data!.docs, [])) {
                  return placeholderContainer('No data available');
                }

                List<String> itemsList = [];
                Map<String, String> itemsMap = {};
                if (dataProvider.isClass) {
                  for (var document in snapshot.data!.docs) {
                    Class classModel = Class.fromDocument(document);
                    String item = classModel.subject! +
                        '/' +
                        classModel.program! +
                        '/' +
                        classModel.semesterSection!;
                    itemsList.add(item);
                    itemsMap[item] = document.id;
                  }
                } else {
                  for (var document in snapshot.data!.docs) {
                    Department departmentModel =
                        Department.fromDocument(document);
                    String item = departmentModel.department! +
                        '/' +
                        departmentModel.location!;
                    itemsList.add(item);
                    itemsMap[item] = document.id;
                  }
                }

                if (dropDownValue == null && documentId == null) {
                  dropDownValue = itemsList[0];
                  documentId = itemsMap[dropDownValue];
                }
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 17.5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Center(
                    child: DropdownButton<String>(
                        style: TextStyle(fontSize: 17, color: Colors.black),
                        value: (dropDownValue != null) ? dropDownValue : null,
                        isExpanded: true,
                        underline: SizedBox(),
                        items: itemsList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Wrap(
                              children: [
                                new Text(value),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropDownValue = value!;
                            documentId = itemsMap[dropDownValue];
                          });
                        }),
                  ),
                );
              })
        ],
      ),
    );
  }

  Container placeholderContainer(text) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 17.5),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Text(text),
    );
  }

  Row tabSelector(dataProvider) {
    return Row(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: 45,
          width: 120,
          decoration: BoxDecoration(
              color: (dataProvider.isClass) ? Color(0xFF06283D) : Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          child: Center(
            child: Text(
              'Class',
              style: TextStyle(
                  color:
                      (dataProvider.isClass) ? Colors.white : Color(0xFF06283D),
                  fontSize: 15),
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: 45,
          width: 120,
          decoration: BoxDecoration(
              color: (dataProvider.isClass) ? Colors.white : Color(0xFF06283D),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Center(
            child: Text(
              'Department',
              style: TextStyle(
                  color:
                      (dataProvider.isClass) ? Color(0xFF06283D) : Colors.white,
                  fontSize: 15),
            ),
          ),
        )
      ],
    );
  }
}
