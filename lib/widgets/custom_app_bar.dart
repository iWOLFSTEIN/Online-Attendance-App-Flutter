import 'package:flutter/material.dart';
import 'package:online_attendence_app/constants/network_objects.dart';
import 'package:online_attendence_app/screens/login_screen.dart';
import 'package:online_attendence_app/widgets/exit_alert_dialogue.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Row(
        children: [
          SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: (() {
              var alert = ExitAlertDialogue();
              showDialog(
                  context: context,
                  builder: (context) {
                    return alert;
                  });
            }),
            child: iconWidget(Icon(Icons.arrow_back)),
          ),
          Expanded(child: Container()),
          GestureDetector(
            onTap: (() {
              var alert = ExitAlertDialogue(
                message: 'Do you want to logout?',
                action: () async {
                  try {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);
                    googleSignInServices.signOutGoogle();
                  } catch (e) {}
                },
              );
              showDialog(
                  context: context,
                  builder: (context) {
                    return alert;
                  });
            }),
            child: iconWidget(
              Icon(
                Icons.power_settings_new,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }

  Material iconWidget(icon) {
    return Material(
        elevation: 8,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(height: 45, width: 41, child: icon));
  }
}
