import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

void ErrorInput(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.deepOrangeAccent,
      textColor: Colors.white,
      fontSize: 16.0);
}

void Successful(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

SvgPicture ScreenBackground(context) {
  return SvgPicture.asset(
    // use SvgPicture for better quality. In different scale the image don't loss quality
    'assets/images/appbackground.svg',
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    fit: BoxFit.fill,

    // color: Colors.green,
  );
}

DecoratedBox AppDropdownCustome(child) {
  return DecoratedBox(
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
      child: child,
    ),
  );
}

ButtonStyle buttonStyleCustomElevated() {
  return ElevatedButton.styleFrom(
      elevation: 2,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)));
}

Ink SubmitButtonChild(buttonText) {
  return Ink(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      // height: 45,
      alignment: Alignment.center,
      child: Text(
        buttonText,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

InputDecoration TextInputCustomeDecoration(lable) {
  return InputDecoration(
      labelText: lable,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey, width: 1),
          borderRadius: BorderRadius.circular(10)),
      filled: true,
      fillColor: Colors.white);
}

SliverGridDelegateWithFixedCrossAxisCount GridStyle() {
  //return type name is hilarious
  return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      // mainAxisExtent: 300,
      mainAxisSpacing: 2,
      childAspectRatio: .5,
      crossAxisSpacing: 2);
}
