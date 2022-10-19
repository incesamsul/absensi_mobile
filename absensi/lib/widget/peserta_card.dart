import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:absensi/constant.dart';

class PesertaCard extends StatelessWidget {
  final IconData icon;
  final String status;
  final String tgl;
  final String jam;
  final void Function()? press;
  final Color color;
  const PesertaCard({
    Key? key,
    required this.icon,
    required this.status,
    required this.tgl,
    required this.jam,
    required this.press,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        margin: EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0, bottom: 20.0),
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: kShadowColor,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(icon),
                  Text(
                    status,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    tgl,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    jam,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
