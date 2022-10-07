import 'package:flutter/material.dart';
import 'package:online_attendence_app/utils/screen_dimensions.dart';
import 'package:online_attendence_app/widgets/custom_text_button.dart';

class GenerateReportScreen extends StatefulWidget {
  const GenerateReportScreen({Key? key}) : super(key: key);

  @override
  State<GenerateReportScreen> createState() => _GenerateReportScreenState();
}

class _GenerateReportScreenState extends State<GenerateReportScreen> {
  bool isClass = true;
  String? dropDownValueClass;
  String? dropDownValueDepartment;
  List<String> itemsClass = [
    'Class 1',
    'Class 2',
    'Class 3',
    'Class 4',
    'Class 5'
  ];
  List<String> itemsDepartment = [
    'Department 1',
    'Department 2',
    'Department 3',
    'Department 4',
    'Department 5'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropDownValueClass = itemsClass[0];
    dropDownValueDepartment = itemsDepartment[0];
  }

  var startDate = DateTime.now().toString().split(' ')[0];
  var endDate = DateTime.now().toString().split(' ')[0];
  @override
  Widget build(BuildContext context) {
    var size = (height(context) * width(context)) / 1000;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            tabSelector(),
            SizedBox(
              height: 25,
            ),
            customDropDownButton(),
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
                    startDate = picked.toString().split(' ')[0];
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
                    endDate = picked.toString().split(' ')[0];
                  });
                }
              },
            ),
            SizedBox(
              height: 50,
            ),
            CustomTextButton(
                buttonHeight: 50,
                action: () {},
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
          // color: Colors.orange,
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
                    date,
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

  Padding customDropDownButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            (isClass) ? 'Class' : 'Department',
            style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w400),
          ),
          Expanded(child: SizedBox()),
          Container(
            width: 225,
            padding: EdgeInsets.symmetric(horizontal: 17.5),
            decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(color: Color(0xFF06283D).withOpacity(0.2)),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Center(
              child: DropdownButton<String>(
                  style: TextStyle(fontSize: 17, color: Colors.black),
                  value: (isClass)
                      ? (dropDownValueClass != null)
                          ? dropDownValueClass
                          : null
                      : (dropDownValueDepartment != null)
                          ? dropDownValueDepartment
                          : null,
                  isExpanded: true,
                  underline: SizedBox(),
                  items: ((isClass) ? itemsClass : itemsDepartment)
                      .map((String value) {
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
                    if (isClass)
                      setState(() {
                        dropDownValueClass = value!;
                      });
                    else
                      setState(() {
                        dropDownValueDepartment = value!;
                      });
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Row tabSelector() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isClass = true;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 45,
            width: 120,
            decoration: BoxDecoration(
                color: (isClass) ? Color(0xFF06283D) : Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Center(
              child: Text(
                'Class',
                style: TextStyle(
                    color: (isClass) ? Colors.white : Color(0xFF06283D),
                    fontSize: 15),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isClass = false;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 45,
            width: 120,
            decoration: BoxDecoration(
                color: (isClass) ? Colors.white : Color(0xFF06283D),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Center(
              child: Text(
                'Department',
                style: TextStyle(
                    color: (isClass) ? Color(0xFF06283D) : Colors.white,
                    fontSize: 15),
              ),
            ),
          ),
        )
      ],
    );
  }
}
