import 'package:ai_cv_generator/models/generation/CVData.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:flutter/material.dart';

class UserData {
  static TextEditingController fnameC = TextEditingController();
  static TextEditingController lnameC = TextEditingController();
  static TextEditingController emailC = TextEditingController();
  static TextEditingController locationC = TextEditingController();
  static TextEditingController phoneNumberC = TextEditingController();
  
  static TextEditingController nameC = TextEditingController();
  static TextEditingController detailsC = TextEditingController();
  static TextEditingController descriptionHeadingC = TextEditingController();
  static TextEditingController descriptionC = TextEditingController();
  static TextEditingController employmentHeadingC = TextEditingController();
  static TextEditingController employmentC = TextEditingController();
  static TextEditingController qualificationHeadingC = TextEditingController();
  static TextEditingController qualificationC = TextEditingController();
  static TextEditingController linksHeadingC = TextEditingController();
  static TextEditingController linksC = TextEditingController();
  
  static UserModel? user;
  static CVData? data;
}