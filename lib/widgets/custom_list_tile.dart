import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.title,
    required this.id,
    required this.trailingWidget,
  }) : super(key: key);

  final String title;
  final String id;
  final Widget trailingWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Color(0xFF06283D),
                      fontSize: 19,
                      // fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    id,
                    style: TextStyle(
                      color: Color(0xFF06283D).withOpacity(0.4),
                      fontSize: 15,
                      // fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            ),
            trailingWidget
            // (showCheckBox)
            // ?
            //  Checkbox(
            //     value: checkBoxValue,
            //     onChanged: (value) {
            //       if (value != null)
            //         setState(() {
            //           checkBoxValue = value;
            //         });
            //     })
            //     : Container(),
          ],
        ),
      ),
    );
  }
}
