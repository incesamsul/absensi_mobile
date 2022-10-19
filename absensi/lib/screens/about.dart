import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/icons/present.svg"),
        Center(
          child: Text(
            "Aplikasi absensi berbasis mobile dengan \n k-means clustering",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ));
  }
}
