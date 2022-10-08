import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/google_sign_in_services.dart';

final firebaseAuth = FirebaseAuth.instance;
final googleSignInServices = GoogleSignInServies();
final firebaseFirestore = FirebaseFirestore.instance;
