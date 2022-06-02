import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buttons({
  required onPress,
  required txt,
}) {
  return Container(
    height: 40,
    width: double.infinity,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPress,
        child: Text(
          txt,
          style: GoogleFonts.mochiyPopPOne(
            fontSize: 30,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        )),
  );
}

Widget customTitle({
  required txt,
  required Color color,
  required double fontSize,
  required FontWeight fontWeight,
}) {
  return Text(
    txt,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.pacifico(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget customText({
  required txt,
  required Color color,
  required double fontSize,
  required FontWeight fontWeight,
}) {
  return Text(
    txt,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.mochiyPopPOne(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

nextPage({
  required BuildContext context,
  required Widget page,
}) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

nextPageUntil({
  required BuildContext context,
  required Widget page,
}) {
  return Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => page), (route) => false);
}

Widget buildFormField({
  Function()? onPress,
  required TextEditingController controller,
  required String hint,
  required TextInputType type,
  required String lable,
   IconData? iconData,
  IconData? icon,
  bool obscure = false,
}) {
  return Container(
    height: 50,
    width: double.infinity,
    child: TextFormField(
      validator: (String? val) {
        if(val!.isEmpty){
          return"this field must be not empty";
        }else{
          return null;
        }
      },
      controller: controller,
      keyboardType: type,
      cursorColor: Colors.green.shade300,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green.shade300),
        ),
        labelStyle: TextStyle(
          color: Colors.green.shade300,
        ),
        fillColor: Colors.grey[100],
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(lable),
        hintText: hint,
        prefixIcon: Icon(iconData),
        suffix: IconButton(
          icon: Icon(icon),
          onPressed: onPress,
        ),
      ),
      obscureText: obscure,
    ),
  );
}

pop({BuildContext? context}) {
  Navigator.pop(context!);
}
