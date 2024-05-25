import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/appstyle.dart';

class CategoryBtn extends StatelessWidget {
  const CategoryBtn(
      {super.key, this.onPress, required this.buttonClr, required this.lable});
  final void Function()? onPress;
  final Color buttonClr;
  final String lable;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPress,
        child: Container(
          height: 45,
          width: MediaQuery.of(context).size.width * 0.255,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: buttonClr,
              style: BorderStyle.solid,
            ),
            borderRadius: const BorderRadius.all(Radius.circular((9))),
          ),
          child: Center(
            child: Text(
              lable,
              style: appstyle(20, buttonClr, FontWeight.w600),
            ),
          ),
        ));
  }
}
