import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_attendence_app/constants/network_objects.dart';
import 'package:online_attendence_app/screens/nav_bar_controller_screen.dart';
import 'package:online_attendence_app/utils/screen_dimensions.dart';
import 'package:online_attendence_app/widgets/exit_alert_dialogue.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var headingStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 45,
      color: Colors.black.withOpacity(0.8),
    );
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: Color(0xFFEAF6F6),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width(context) * 4 / 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        var alert = ExitAlertDialogue();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return alert;
                            });
                      },
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.black.withOpacity(0.4),
                        size: 30,
                      ),
                    ),
                    Container(
                      height: height(context) * 3 / 100,
                    ),
                    Text("Attendance Online", style: headingStyle),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Take attendance, generate reports and much more",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black.withOpacity(0.4),
                        // fontWeight: FontWeight.w600
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "images/attendance.png",
                  height: height(context) * 30 / 100,
                  width: width(context) * 60 / 100,
                ),
              ),
              Wrap(
                children: [
                  Text(
                    "Take attendance of your class, school or university anywhere, anytime",
                    style: TextStyle(
                        fontSize: 18, color: Colors.black.withOpacity(0.4)),
                  )
                ],
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      try {
                        User? user =
                            await googleSignInServices.signInWithGoogle();

                        if (user != null) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NavBarControllerScreen()),
                              (route) => false);
                        }
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.black
                        // Color(0xFF14213D),
                        ),
                    child: Row(
                      children: [
                        Expanded(child: Container()),
                        Image.asset(
                          "images/google_logo.png",
                          height: 23,
                          width: 23,
                        ),
                        // Expanded(child: Container()),
                        Container(
                          width: 15,
                        ),
                        const Text(
                          "Continue with Google",
                          style:
                              // GoogleFonts.montserrat(
                              //   textStyle:
                              TextStyle(fontSize: 17.5, color: Colors.white),
                        ),
                        // ),
                        Container(
                          width: width(context) * 2 / 100,
                        ),
                        Expanded(child: Container()),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
